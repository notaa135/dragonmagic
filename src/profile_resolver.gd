# profile_resolver.gd — Loads ProfileRules and resolves learner constraints.
# domain: QUIZ
class_name ProfileResolver
extends RefCounted

var _profiles: Dictionary = {}
var _default_id: String = "g2"


func load_profiles(path: String) -> bool:
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_warning("ProfileResolver: cannot open " + path)
		return false
	var data = JSON.parse_string(file.get_as_text())
	if not data is Dictionary or not data.has("profiles"):
		return false
	for p in data["profiles"]:
		var pid: String = p.get("profile_id", "")
		if pid.is_empty(): continue
		_profiles[pid] = p
	_default_id = data.get("default_profile", "g2")
	return true


func resolve(profile_id: String) -> Dictionary:
	if _profiles.has(profile_id):
		return _profiles[profile_id]
	if _profiles.has(_default_id):
		return _profiles[_default_id]
	return _make_fallback()


func get_option_count_range(profile: Dictionary) -> Array:
	return profile.get("option_count_range", [4, 4])


func get_penalty_config(profile: Dictionary) -> Dictionary:
	return profile.get("penalty_config", {
		"buff_pct": 0.15,
		"base_damage_mult": 1.0,
		"allow_retry_on_wrong": false,
	})


func is_timer_off(profile: Dictionary) -> bool:
	return profile.get("timer_policy", "standard") == "off"


func is_hint_allowed(profile: Dictionary) -> bool:
	return profile.get("hint_policy", "none") != "none"


func get_difficulty_cap(profile: Dictionary) -> float:
	return profile.get("difficulty_cap", 5.0)


func requires_beginner_safe(profile: Dictionary) -> bool:
	return profile.get("safe_for_beginner_required", false)


func get_allowed_subjects(profile: Dictionary) -> Array:
	return profile.get("allowed_subjects", ["MATH", "ENGLISH", "REASONING"])


func get_session_defaults(profile: Dictionary) -> Dictionary:
	return profile.get("session_defaults", {
		"count": 10, "review_pct": 30, "new_pct": 50, "challenge_pct": 20,
	})


func get_default_id() -> String:
	return _default_id


func has_profile(pid: String) -> bool:
	return _profiles.has(pid)


func _make_fallback() -> Dictionary:
	return {
		"profile_id": "fallback",
		"grade_band": "G2",
		"allowed_subjects": ["MATH", "ENGLISH", "REASONING"],
		"allowed_item_types": ["mcq_single"],
		"allowed_packs": ["core_math", "core_english", "core_reasoning"],
		"option_count_range": [4, 4],
		"timer_policy": "optional",
		"hint_policy": "limited",
		"safe_for_beginner_required": false,
		"difficulty_cap": 3.5,
		"penalty_config": {"buff_pct": 0.15, "base_damage_mult": 1.0,
			"allow_retry_on_wrong": false},
		"session_defaults": {"count": 10, "review_pct": 30,
			"new_pct": 50, "challenge_pct": 20},
	}
