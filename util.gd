extends RefCounted

class_name Util

static func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

static func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference

static func rotate_toward(current_angle, target_angle, max_rotation):
	var diff = current_angle - target_angle
	if diff > PI:
		diff -= PI * 2
	elif diff < -PI:
		diff += PI * 2

	var clamped_diff = clamp(diff, -max_rotation, max_rotation)
	return current_angle + clamped_diff
