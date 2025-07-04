/// Datum which stores information about a matrix decomposed with decompose().
/datum/decompose_matrix
	///?
	var/scale_x = 1
	///?
	var/scale_y = 1
	///?
	var/rotation = 0
	///?
	var/shift_x = 0
	///?
	var/shift_y = 0

/// Decomposes a matrix into scale, shift and rotation.
///
/// If other operations were applied on the matrix, such as shearing, the result
/// will not be precise.
///
/// Negative scales are now supported. =)
/matrix/proc/decompose()
	var/datum/decompose_matrix/decompose_matrix = new
	. = decompose_matrix
	var/flip_sign = (a*e - b*d < 0)? -1 : 1 // Det < 0 => only 1 axis is flipped - start doing some sign flipping
	// If both axis are flipped, nothing bad happens and Det >= 0, it just treats it like a 180° rotation
	// If only 1 axis is flipped, we need to flip one direction - in this case X, so we flip a, b and the x scaling
	decompose_matrix.scale_x = sqrt(a * a + d * d) * flip_sign
	decompose_matrix.scale_y = sqrt(b * b + e * e)
	decompose_matrix.shift_x = c
	decompose_matrix.shift_y = f
	if(!decompose_matrix.scale_x || !decompose_matrix.scale_y)
		return
	// If only translated, scaled and rotated, a/xs == e/ys and -d/xs == b/xy
	var/cossine = (a/decompose_matrix.scale_x + e/decompose_matrix.scale_y) / 2
	var/sine = (b/decompose_matrix.scale_y - d/decompose_matrix.scale_x) / 2 * flip_sign
	decompose_matrix.rotation = arctan(cossine, sine) * flip_sign

/matrix/proc/TurnTo(old_angle, new_angle)
	. = new_angle - old_angle
	Turn(.) //BYOND handles cases such as -270, 360, 540 etc. DOES NOT HANDLE 180 TURNS WELL, THEY TWEEN AND LOOK LIKE SHIT

/// Does a jitter animation, with a few settings so as to allow changing the animation as needed:
/// - jitter: The amount of jitter in this animation. Extremely high values, such as 500 or 1000, are recommended.
/// - jitter_duration: The duration of the jitter animation.
/// - jitter_loops: The amount of times to loop this animation.
/atom/proc/do_jitter_animation(jitteriness = 1000, jitter_duration = 2, jitter_loops = 6)
	var/amplitude = min(4, (jitteriness * 0.01) + 1)
	var/pixel_x_diff = rand(-amplitude, amplitude)
	var/pixel_y_diff = rand(-amplitude/3, amplitude/3)
	var/final_pixel_x = initial(pixel_x)
	var/final_pixel_y = initial(pixel_y)
	animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff , time = jitter_duration, loop = jitter_loops, flags = ANIMATION_PARALLEL)
	animate(pixel_x = final_pixel_x , pixel_y = final_pixel_y , time = jitter_duration, loop = jitter_loops)

/atom/proc/SpinAnimation(speed = 10, loops = -1, clockwise = 1, segments = 3, parallel = TRUE)
	if(!segments)
		return
	var/segment = 360 / segments
	if(!clockwise)
		segment = -segment
	var/list/matrices = list()
	for(var/i in 1 to segments - 1)
		var/matrix/M = matrix(transform)
		M.Turn(segment * i)
		matrices += M
	var/matrix/last = matrix(transform)
	matrices += last

	speed /= segments

	if(parallel)
		animate(src, transform = matrices[1], time = speed, loops , flags = ANIMATION_PARALLEL)
	else
		animate(src, transform = matrices[1], time = speed, loops)
	for(var/i in 2 to segments) //2 because 1 is covered above
		animate(transform = matrices[i], time = speed)
		//doesn't have an object argument because this is "Stacking" with the animate call above
		//3 billion% intentional

/**
 * Shear the transform on either or both axes.
 * * x - X axis shearing
 * * y - Y axis shearing
 */
/matrix/proc/Shear(x, y)
	return Multiply(matrix(1, x, 0, y, 1, 0))

//Dumps the matrix data in format a-f
/matrix/proc/tolist()
	. = list()
	. += a
	. += b
	. += c
	. += d
	. += e
	. += f


//Dumps the matrix data in a matrix-grid format
/*
a d 0
b e 0
c f 1
*/
/matrix/proc/togrid()
	. = list()
	. += a
	. += d
	. += 0
	. += b
	. += e
	. += 0
	. += c
	. += f
	. += 1


//The X pixel offset of this matrix
/matrix/proc/get_x_shift()
	. = c


//The Y pixel offset of this matrix
/matrix/proc/get_y_shift()
	. = f


/matrix/proc/get_x_skew()
	. = b


/matrix/proc/get_y_skew()
	. = d


//Skews a matrix in a particular direction
//Missing arguments are treated as no skew in that direction

//As Rotation is defined as a scale+skew, these procs will break any existing rotation
//Unless the result is multiplied against the current matrix
/matrix/proc/set_skew(x = 0, y = 0)
	b = x
	d = y


/////////////////////
// COLOUR MATRICES //
/////////////////////

/* Documenting a couple of potentially useful color matrices here to inspire ideas
// Greyscale - indentical to saturation @ 0
list(LUMA_R,LUMA_R,LUMA_R,0, LUMA_G,LUMA_G,LUMA_G,0, LUMA_B,LUMA_B,LUMA_B,0, 0,0,0,1, 0,0,0,0)

// Color inversion
list(-1,0,0,0, 0,-1,0,0, 0,0,-1,0, 0,0,0,1, 1,1,1,0)

// Sepiatone
list(0.393,0.349,0.272,0, 0.769,0.686,0.534,0, 0.189,0.168,0.131,0, 0,0,0,1, 0,0,0,0)
*/

//Does nothing
/proc/color_matrix_identity()
	return list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

//Adds/subtracts overall lightness
//0 is identity, 1 makes everything white, -1 makes everything black
/proc/color_matrix_lightness(power)
	return list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, power,power,power,0)

//Changes distance hues have from grey while maintaining the overall lightness. Greys are unaffected.
//1 is identity, 0 is greyscale, >1 oversaturates colors
/proc/color_matrix_saturation(value)
	var/inv = 1 - value
	var/R = round(LUMA_R * inv, 0.001)
	var/G = round(LUMA_G * inv, 0.001)
	var/B = round(LUMA_B * inv, 0.001)

	return list(R + value,R,R,0, G,G + value,G,0, B,B,B + value,0, 0,0,0,1, 0,0,0,0)

//Changes distance colors have from rgb(127,127,127) grey
//1 is identity. 0 makes everything grey >1 blows out colors and greys
/proc/color_matrix_contrast(value)
	var/add = (1 - value) * 0.5
	return list(value,0,0,0, 0,value,0,0, 0,0,value,0, 0,0,0,1, add,add,add,0)

//Moves all colors angle degrees around the color wheel while maintaining intensity of the color and not affecting greys
//0 is identity, 120 moves reds to greens, 240 moves reds to blues
/proc/color_matrix_rotate_hue(angle)
	var/sin = sin(angle)
	var/cos = cos(angle)
	var/cos_inv_third = 0.333*(1-cos)
	var/sqrt3_sin = sqrt(3)*sin
	return list(
round(cos+cos_inv_third, 0.001), round(cos_inv_third+sqrt3_sin, 0.001), round(cos_inv_third-sqrt3_sin, 0.001), 0,
round(cos_inv_third-sqrt3_sin, 0.001), round(cos+cos_inv_third, 0.001), round(cos_inv_third+sqrt3_sin, 0.001), 0,
round(cos_inv_third+sqrt3_sin, 0.001), round(cos_inv_third-sqrt3_sin, 0.001), round(cos+cos_inv_third, 0.001), 0,
0,0,0,1,
0,0,0,0)

//These next three rotate values about one axis only
//x is the red axis, y is the green axis, z is the blue axis.
/proc/color_matrix_rotate_x(angle)
	var/sinval = round(sin(angle), 0.001); var/cosval = round(cos(angle), 0.001)
	return list(1,0,0,0, 0,cosval,sinval,0, 0,-sinval,cosval,0, 0,0,0,1, 0,0,0,0)

/proc/color_matrix_rotate_y(angle)
	var/sinval = round(sin(angle), 0.001); var/cosval = round(cos(angle), 0.001)
	return list(cosval,0,-sinval,0, 0,1,0,0, sinval,0,cosval,0, 0,0,0,1, 0,0,0,0)

/proc/color_matrix_rotate_z(angle)
	var/sinval = round(sin(angle), 0.001); var/cosval = round(cos(angle), 0.001)
	return list(cosval,sinval,0,0, -sinval,cosval,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

//Returns a matrix addition of A with B
/proc/color_matrix_add(list/A, list/B)
	if(!istype(A) || !istype(B))
		return color_matrix_identity()
	if(length(A) != 20 || length(B) != 20)
		return color_matrix_identity()
	var/list/output = list()
	output.len = 20
	for(var/value in 1 to 20)
		output[value] = A[value] + B[value]
	return output

//Returns a matrix multiplication of A with B
/proc/color_matrix_multiply(list/A, list/B)
	if(!istype(A) || !istype(B))
		return color_matrix_identity()
	if(length(A) != 20 || length(B) != 20)
		return color_matrix_identity()
	var/list/output = list()
	output.len = 20
	var/x = 1
	var/y = 1
	var/offset = 0
	for(y in 1 to 5)
		offset = (y-1)*4
		for(x in 1 to 4)
			output[offset+x] = round(A[offset+1]*B[x] + A[offset+2]*B[x+4] + A[offset+3]*B[x+8] + A[offset+4]*B[x+12]+(y==5?B[x+16]:0), 0.001)
	return output

/*Changing/updating a mob's client color matrices. These render over the map window and affect most things the player sees, except things like inventory,
text popups, HUD, and some fullscreens. Code based on atom filter code, since these have similar issues with application order - for ex. if you have
a desaturation and a recolor matrix, you'll get very different results if you desaturate before recoloring, or recolor before desaturating.
See matrices.dm for the matrix procs.
If you want to recolor a specific atom, you should probably do it as a color matrix filter instead since that code already exists.
Apparently color matrices are not the same sort of matrix used by matrix datums and can't be worked with using normal matrix procs.*/

///Adds a color matrix and updates the client. Priority is the order the matrices are applied, lowest first. Will replace an existing matrix of the same name, if one exists.
/mob/proc/add_client_color_matrix(name, priority, list/params, time, easing)
	LAZYINITLIST(client_color_matrices)

	//Package the matrices in another list that stores priority.
	client_color_matrices[name] = list("priority" = priority, "color_matrix" = params.Copy())

	update_client_color_matrices(time, easing)

/**Combines all color matrices and applies them to the client.
Also used on login to give a client its new body's color matrices.
Responsible for sorting the matrices.
Transition is animated but instant by default.**/
/mob/proc/update_client_color_matrices(time = 0 SECONDS, easing = LINEAR_EASING)
	if(!client)
		return

	if(!length(client_color_matrices))
		animate(client, color = null, time = time, easing = easing)
		UNSETEMPTY(client_color_matrices)
		SEND_SIGNAL(src, COMSIG_MOB_RECALCULATE_CLIENT_COLOR)
		return

	//Sort the matrix packages by priority.
	client_color_matrices = sortTim(client_color_matrices, GLOBAL_PROC_REF(cmp_filter_data_priority), TRUE)

	var/list/final_matrix

	for(var/package in client_color_matrices)
		var/list/current_matrix = client_color_matrices[package]["color_matrix"]
		if(!final_matrix)
			final_matrix = current_matrix
		else
			final_matrix = color_matrix_multiply(final_matrix, current_matrix)

	animate(client, color = final_matrix, time = time, easing = easing)
	SEND_SIGNAL(src, COMSIG_MOB_RECALCULATE_CLIENT_COLOR)

///Changes a matrix package's priority and updates client.
/mob/proc/change_client_color_matrix_priority(name, new_priority, time, easing)
	if(!client_color_matrices || !client_color_matrices[name])
		return

	client_color_matrices[name]["priority"] = new_priority

	update_client_color_matrices(time, easing)

///Returns the matrix of that name, if it exists.
/mob/proc/get_client_color_matrix(name)
	return client_color_matrices[name]["color_matrix"]

///Can take either a single name or a list of several. Attempts to remove target matrix packages and update client.
/mob/proc/remove_client_color_matrix(name_or_names, time, easing)
	if(!client_color_matrices)
		return

	var/found = FALSE
	var/list/names = islist(name_or_names) ? name_or_names : list(name_or_names)

	for(var/name in names)
		if(client_color_matrices[name])
			client_color_matrices -= name
			found = TRUE

	if(found)
		update_client_color_matrices(time, easing)

///Removes all matrices and updates client.
/mob/proc/clear_client_color_matrices(time, easing)
	client_color_matrices = null
	update_client_color_matrices(time, easing)
