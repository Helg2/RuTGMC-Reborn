GLOBAL_LIST_INIT(blacklisted_automated_baseturfs, typecacheof(list(
	/turf/open/space,
	/turf/baseturf_bottom,
)))

/// Take off the top layer turf and replace it with the next baseturf down
/turf/proc/scrape_away(amount = 1, flags)
	if(!amount)
		return
	if(!length(baseturfs))
		if(baseturfs == type)
			return src
		return change_turf(baseturfs, baseturfs, flags) // The bottom baseturf will never go away

	var/list/new_baseturfs = baseturfs.Copy()
	var/turf_type = new_baseturfs[max(1, length(new_baseturfs) - amount + 1)]
	while(ispath(turf_type, /turf/baseturf_skipover))
		amount++
		if(amount > length(new_baseturfs))
			CRASH("The bottomost baseturf of a turf is a skipover [src]([type])")
		turf_type = new_baseturfs[max(1, length(new_baseturfs) - amount + 1)]
	new_baseturfs.len -= min(amount, length(new_baseturfs) - 1) // No removing the very bottom
	if(length(new_baseturfs) == 1)
		new_baseturfs = new_baseturfs[1]
	return change_turf(turf_type, new_baseturfs, flags)

/// Places the given turf on the bottom of the turf stack.
/turf/proc/place_on_bottom(turf/bottom_turf)
	baseturfs = baseturfs_string_list(
		list(initial(bottom_turf.baseturfs), bottom_turf) + baseturfs,
		src
	)

/// Make a new turf and put it on top
/// The args behave identical to place_on_bottom except they go on top
/// Things placed on top of closed turfs will ignore the topmost closed turf
/// Returns the new turf
/turf/proc/place_on_top(turf/added_layer, flags)
	var/list/turf/new_baseturfs = list()

	new_baseturfs.Add(baseturfs)
	if(isopenturf(src))
		new_baseturfs.Add(type)

	return change_turf(added_layer, new_baseturfs, flags)

/// Places a turf on top - for map loading
/turf/proc/load_on_top(turf/added_layer, flags)
	var/area/our_area = get_area(src)
	flags = our_area.PlaceOnTopReact(list(baseturfs), added_layer, flags)

	if(flags & CHANGETURF_SKIP) // We haven't been initialized
		if(atom_flags & INITIALIZED)
			stack_trace("CHANGETURF_SKIP was used in a place_on_top call for a turf that's initialized. This is a mistake. [src]([type])")
		assemble_baseturfs()

	var/turf/new_turf
	if(!length(baseturfs))
		baseturfs = list(baseturfs)

	var/list/old_baseturfs = baseturfs.Copy()
	if(!isclosedturf(src))
		old_baseturfs += type

	new_turf = change_turf(added_layer, null, flags)
	new_turf.assemble_baseturfs(initial(added_layer.baseturfs)) // The baseturfs list is created like roundstart
	if(!length(new_turf.baseturfs))
		new_turf.baseturfs = list(baseturfs)

	// The old baseturfs are put underneath, and we sort out the unwanted ones
	new_turf.baseturfs = baseturfs_string_list(old_baseturfs + (new_turf.baseturfs - GLOB.blacklisted_automated_baseturfs), new_turf)
	return new_turf

/// Copy an existing turf and put it on top
/// Returns the new turf
/turf/proc/copy_on_top(turf/copytarget, ignore_bottom=1, depth=INFINITY, copy_air = FALSE)
	var/list/new_baseturfs = list()
	new_baseturfs += baseturfs
	new_baseturfs += type

	if(depth)
		var/list/target_baseturfs
		if(length(copytarget.baseturfs))
			// with default inputs this would be Copy(clamp(2, -INFINITY, length(baseturfs)))
			// Don't forget a lower index is lower in the baseturfs stack, the bottom is baseturfs[1]
			target_baseturfs = copytarget.baseturfs.Copy(clamp(1 + ignore_bottom, 1 + length(copytarget.baseturfs) - depth, length(copytarget.baseturfs)))
		else if(!ignore_bottom)
			target_baseturfs = list(copytarget.baseturfs)
		if(target_baseturfs)
			target_baseturfs -= new_baseturfs & GLOB.blacklisted_automated_baseturfs
			new_baseturfs += target_baseturfs

	var/turf/newT = copytarget.copyTurf(src, copy_air)
	newT.baseturfs = new_baseturfs
	return newT

/// Tries to find the given type in baseturfs.
/// If found, returns how deep it is for use in other baseturf procs, or null if it cannot be found.
/// For example, this number can be passed into scrape_away to scrape everything until that point.
/turf/proc/depth_to_find_baseturf(baseturf_type)
	if(!islist(baseturfs))
		return baseturfs == baseturf_type ? 1 : null
	var/index = baseturfs.Find(baseturf_type)
	if(index == 0)
		return null
	return baseturfs.len - index + 1

/// Returns the baseturf at the given depth.
/// For example, baseturf_at_depth(1) will give the baseturf that would show up when scraping once.
/turf/proc/baseturf_at_depth(index)
	//TEST_ONLY_ASSERT(isnum(index), "baseturf_at_depth must be given a number, received [index]")
	if(islist(baseturfs))
		return LAZYACCESS(baseturfs, baseturfs.len - index + 1)
	else if (index == 1)
		return baseturfs
	return null

/// Replaces all instances of needle_type in baseturfs with replacement_type
/turf/proc/replace_baseturf(needle_type, replacement_type)
	if(islist(baseturfs))
		var/list/new_baseturfs

		while(TRUE)
			var/found_index = baseturfs.Find(needle_type)
			if(found_index == 0)
				break

			new_baseturfs ||= baseturfs.Copy()
			new_baseturfs[found_index] = replacement_type

		if(!isnull(new_baseturfs))
			baseturfs = baseturfs_string_list(new_baseturfs, src)
	else if(baseturfs == needle_type)
		baseturfs = replacement_type

/// Removes all baseturfs that are found in the given typecache.
/turf/proc/remove_baseturfs_from_typecache(list/typecache)
	if(islist(baseturfs))
		var/list/new_baseturfs

		for(var/baseturf in baseturfs)
			if(!typecache[baseturf])
				continue

			new_baseturfs ||= baseturfs.Copy()
			new_baseturfs -= baseturf

		if(!isnull(new_baseturfs))
			baseturfs = baseturfs_string_list(new_baseturfs, src)
	else if(typecache[baseturfs])
		baseturfs = /turf/baseturf_bottom

/// Returns the total number of baseturfs
/turf/proc/count_baseturfs()
	return islist(baseturfs) ? length(baseturfs) : 1

/// Inserts a baseturf at the given level.
/// "Level" here doesn't mean depth.
/// For example, `insert_baseturf(2, /turf/open/floor/plating)` will make it so
/// the 2nd to last turf in the list is plating.
/// This is different from *depth*, since depth is the level from the top.
/turf/proc/insert_baseturf(level, turf_type)
	if (!islist(baseturfs))
		assemble_baseturfs()
		if(!islist(baseturfs))
			baseturfs = list(baseturfs)

	var/list/baseturfs_copy = baseturfs.Copy()
	baseturfs_copy.Insert(level, turf_type)
	baseturfs = baseturfs_string_list(baseturfs_copy, src)
