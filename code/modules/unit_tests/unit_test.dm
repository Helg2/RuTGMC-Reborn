/*

Usage:
Override /Run() to run your test code

Call Fail() to fail the test (You should specify a reason)

You may use /New() and /Destroy() for setup/teardown respectively

You can use the run_loc_floor_bottom_left and run_loc_floor_top_right to get turfs for testing

*/

GLOBAL_DATUM(current_test, /datum/unit_test)
GLOBAL_VAR_INIT(failed_any_test, FALSE)
/// When unit testing, all logs sent to log_mapping are stored here.
GLOBAL_LIST_EMPTY(unit_test_mapping_logs)

/// A list of every test that is currently focused.
/// Use the PERFORM_ALL_TESTS macro instead.
GLOBAL_VAR_INIT(focused_tests, focused_tests())

/proc/focused_tests()
	var/list/focused_tests = list()
	for (var/datum/unit_test/unit_test as anything in subtypesof(/datum/unit_test))
		if (initial(unit_test.focus))
			focused_tests += unit_test

	return focused_tests.len > 0 ? focused_tests : null

/datum/unit_test
	//Bit of metadata for the future maybe
	var/list/procs_tested

	/// The bottom left floor turf of the testing zone
	var/turf/run_loc_floor_bottom_left

	/// The top right floor turf of the testing zone
	var/turf/run_loc_floor_top_right

	///The priority of the test, the larger it is the later it fires
	var/priority = TEST_DEFAULT

	//internal shit
	var/focus = FALSE
	var/succeeded = TRUE
	var/list/allocated
	var/list/fail_reasons

	var/static/datum/space_level/reservation

/datum/unit_test/New()
	if (isnull(reservation))
		var/datum/map_template/unit_tests/template = new
		reservation = template.load_new_z()

	allocated = new
	run_loc_floor_bottom_left = get_turf(locate(/obj/effect/landmark/unit_test_bottom_left) in GLOB.landmarks_list)
	run_loc_floor_top_right = get_turf(locate(/obj/effect/landmark/unit_test_top_right) in GLOB.landmarks_list)

	TEST_ASSERT(isfloorturf(run_loc_floor_bottom_left), "run_loc_floor_bottom_left was not a floor ([run_loc_floor_bottom_left])")
	TEST_ASSERT(isfloorturf(run_loc_floor_top_right), "run_loc_floor_top_right was not a floor ([run_loc_floor_top_right])")

/datum/unit_test/Destroy()
	// clear the test area
	for(var/turf/turf in block(locate(1, 1, run_loc_floor_bottom_left.z), locate(world.maxx, world.maxy, run_loc_floor_bottom_left.z)))
		for(var/content in turf.contents)
			if(iseffect(content))
				continue
			qdel(content)
	QDEL_LIST(allocated)
	return ..()

/proc/cmp_unit_test_priority(datum/unit_test/a, datum/unit_test/b)
	return initial(a.priority) - initial(b.priority)

/datum/unit_test/proc/Run()
	Fail("Run() called parent or not implemented")

/datum/unit_test/proc/Fail(reason = "No reason")
	succeeded = FALSE

	if(!istext(reason))
		reason = "FORMATTED: [reason != null ? reason : "NULL"]"

	LAZYADD(fail_reasons, reason)

/// Allocates an instance of the provided type, and places it somewhere in an available loc
/// Instances allocated through this proc will be destroyed when the test is over
/datum/unit_test/proc/allocate(type, ...)
	var/list/arguments = args.Copy(2)
	if (!length(arguments))
		arguments = list(run_loc_floor_bottom_left)
	else if (arguments[1] == null)
		arguments[1] = run_loc_floor_bottom_left
	var/instance = new type(arglist(arguments))
	allocated += instance
	return instance

/// Logs a test message. Will use GitHub action syntax found at https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
/datum/unit_test/proc/log_for_test(text, priority, file, line)
	var/map_name = SSmapping.configs[GROUND_MAP].map_name + "(" + SSmapping.configs[SHIP_MAP].map_name + ")"

	// Need to escape the text to properly support newlines.
	var/annotation_text = replacetext(text, "%", "%25")
	annotation_text = replacetext(annotation_text, "\n", "%0A")

	log_world("::[priority] file=[file],line=[line],title=[map_name]: [type]::[annotation_text]")

/proc/RunUnitTest(test_path, list/test_results)
	if(ispath(test_path, /datum/unit_test/focus_only))
		return

	var/datum/unit_test/test = new test_path

	GLOB.current_test = test
	var/duration = REALTIMEOFDAY

	test.Run()

	duration = REALTIMEOFDAY - duration
	GLOB.current_test = null
	GLOB.failed_any_test |= !test.succeeded

	var/list/log_entry = list("[test.succeeded ? "PASS" : "FAIL"]: [test_path] [duration * 0.1]s")
	var/list/fail_reasons = test.fail_reasons

	for(var/J in 1 to LAZYLEN(fail_reasons))
		log_entry += "\tREASON #[J]: [fail_reasons[J]]"
		//TODO missing tg's logging what map it failed on
	var/message = log_entry.Join("\n")
	log_test(message)

	test_results[test_path] = list("status" = test.succeeded ? UNIT_TEST_PASSED : UNIT_TEST_FAILED, "message" = message, "name" = test_path)

	qdel(test)

/proc/RunUnitTests()
	CHECK_TICK

	var/list/tests_to_run = subtypesof(/datum/unit_test)
	for (var/_test_to_run in tests_to_run)
		var/datum/unit_test/test_to_run = _test_to_run
		if (initial(test_to_run.focus))
			tests_to_run = list(test_to_run)
			break

	tests_to_run = sortTim(tests_to_run, /proc/cmp_unit_test_priority)

	var/list/test_results = list()

	for(var/unit_path in tests_to_run)
		CHECK_TICK //We check tick first because the unit test we run last may be so expensive that checking tick will lock up this loop forever
		RunUnitTest(unit_path, test_results)

	var/file_name = "data/unit_tests.json"
	fdel(file_name)
	file(file_name) << json_encode(test_results)

	SSticker.force_ending = TRUE
	//We have to call this manually because del_text can preceed us, and SSticker doesn't fire in the post game
	SSticker.Reboot()

/datum/map_template/unit_tests
	name = "Unit Tests Zone"
	mappath = "_maps/templates/unit_tests.dmm"
