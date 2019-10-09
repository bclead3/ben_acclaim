require 'test_helper'

class HeroesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hero = heroes(:one)
  end

  test "should get index" do
    get heroes_url
    assert_response :success
  end

  test "should get new" do
    get new_hero_url
    assert_response :success
  end

  test "should create hero" do
    assert_difference('Hero.count') do
      post heroes_url, params: { hero: { badge_template_id: @hero.badge_template_id, country_name: @hero.country_name, email: @hero.email, expires_at: @hero.expires_at, first_name: @hero.first_name, issued_at: @hero.issued_at, issuer_earner_id: @hero.issuer_earner_id, last_name: @hero.last_name, locale: @hero.locale, state_or_province: @hero.state_or_province, suppress_badge_notification_email: @hero.suppress_badge_notification_email } }
    end

    assert_redirected_to hero_url(Hero.last)
  end

  test "should show hero" do
    get hero_url(@hero)
    assert_response :success
  end

  test "should get edit" do
    get edit_hero_url(@hero)
    assert_response :success
  end

  test "should update hero" do
    patch hero_url(@hero), params: { hero: { badge_template_id: @hero.badge_template_id, country_name: @hero.country_name, email: @hero.email, expires_at: @hero.expires_at, first_name: @hero.first_name, issued_at: @hero.issued_at, issuer_earner_id: @hero.issuer_earner_id, last_name: @hero.last_name, locale: @hero.locale, state_or_province: @hero.state_or_province, suppress_badge_notification_email: @hero.suppress_badge_notification_email } }
    assert_redirected_to hero_url(@hero)
  end

  test "should destroy hero" do
    assert_difference('Hero.count', -1) do
      delete hero_url(@hero)
    end

    assert_redirected_to heroes_url
  end
end
