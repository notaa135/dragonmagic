# Synthetic boundary checks for the unchanged learner-profile component.
extends SceneTree

const Resolver = preload("res://src/profile_resolver.gd")
const FIXTURE = "res://tests/fixtures/profiles.json"
var _checks := 0
var _failures := 0

func _init() -> void:
	_test_unloaded_fallback()
	_test_loaded_profiles()
	_test_missing_settings()
	print("Profile resolver checks: %d passed, %d failed" % [_checks - _failures, _failures])
	quit(0 if _failures == 0 else 1)

func _check(condition: bool, label: String) -> void:
	_checks += 1
	if not condition:
		_failures += 1
		push_error("FAIL: " + label)

func _test_unloaded_fallback() -> void:
	var resolver := Resolver.new()
	var profile: Dictionary = resolver.resolve("unavailable")
	_check(profile.get("profile_id") == "fallback", "unloaded resolver returns fallback")
	_check(resolver.get_default_id() == "g2", "initial default ID remains defined")
	_check(not resolver.has_profile("unavailable"), "unknown profile is not registered")
	_check(is_equal_approx(resolver.get_difficulty_cap(profile), 3.5), "fallback difficulty")
	_check(resolver.is_hint_allowed(profile), "fallback permits limited hints")
	_check(not resolver.is_timer_off(profile), "optional timer is not explicit off")
	_check(resolver.get_session_defaults(profile).get("count") == 10, "fallback session length")

func _test_loaded_profiles() -> void:
	var resolver := Resolver.new()
	_check(resolver.load_profiles(FIXTURE), "synthetic fixture loads")
	_check(resolver.get_default_id() == "beginner_sample", "configured default is retained")
	_check(resolver.has_profile("challenge_sample"), "explicit profile is registered")
	var beginner: Dictionary = resolver.resolve("beginner_sample")
	var unknown: Dictionary = resolver.resolve("missing_sample")
	_check(unknown == beginner, "unknown ID resolves to the configured default")
	_check(resolver.is_timer_off(beginner), "beginner disables timer")
	_check(resolver.is_hint_allowed(beginner), "beginner allows hints")
	_check(resolver.requires_beginner_safe(beginner), "beginner safety flag is retained")
	_check(is_equal_approx(resolver.get_difficulty_cap(beginner), 2.5), "beginner difficulty")
	var options: Array = resolver.get_option_count_range(beginner)
	_check(options.size() == 2 and options[0] == 2 and options[1] == 3, "beginner answer-count range")
	_check(resolver.get_allowed_subjects(beginner) == ["MATH"], "beginner subject restriction")
	_check(resolver.get_penalty_config(beginner).get("buff_pct") == 0.0, "zero penalty retained")
	_check(resolver.get_session_defaults(beginner).get("count") == 4, "beginner session length")
	var challenge: Dictionary = resolver.resolve("challenge_sample")
	_check(challenge.get("profile_id") == "challenge_sample", "explicit ID overrides default")
	_check(not resolver.is_timer_off(challenge), "challenge keeps timer enabled")
	_check(not resolver.is_hint_allowed(challenge), "challenge disables hints")
	_check(not resolver.requires_beginner_safe(challenge), "false safety flag is retained")
	_check(is_equal_approx(resolver.get_difficulty_cap(challenge), 7.0), "challenge difficulty")
	_check(resolver.get_allowed_subjects(challenge) == ["MATH", "REASONING"], "challenge subjects")
	_check(not resolver.get_penalty_config(challenge).get("allow_retry_on_wrong"), "no retry")

func _test_missing_settings() -> void:
	var resolver := Resolver.new()
	_check(resolver.get_option_count_range({}) == [4, 4], "absent option settings default")
	_check(not resolver.is_hint_allowed({}), "absent hint setting defaults to none")
	_check(not resolver.is_timer_off({}), "absent timer setting defaults to standard")
	_check(is_equal_approx(resolver.get_difficulty_cap({}), 5.0), "absent difficulty default")
	_check(resolver.get_session_defaults({}).get("count") == 10, "absent session defaults")
