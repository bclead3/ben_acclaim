require "application_system_test_case"

class HeroesTest < ApplicationSystemTestCase
  setup do
    @hero = heroes(:one)
  end

  test "visiting the index" do
    visit heroes_url
    assert_selector "h1", text: "Heroes"
  end

  test "creating a Hero" do
    visit heroes_url
    click_on "New Hero"

    fill_in "Badge template", with: @hero.badge_template_id
    fill_in "Country name", with: @hero.country_name
    fill_in "Recipient email", with: @hero.recipient_email
    fill_in "Expires at", with: @hero.expires_at
    fill_in "First name", with: @hero.first_name
    fill_in "Issued at", with: @hero.issued_at
    fill_in "Issuer earner", with: @hero.issuer_earner_id
    fill_in "Last name", with: @hero.last_name
    fill_in "Locale", with: @hero.locale
    fill_in "State or province", with: @hero.state_or_province
    check "Suppress badge notification email" if @hero.suppress_badge_notification_email
    click_on "Create Hero"

    assert_text "Hero was successfully created"
    click_on "Back"
  end

  test "updating a Hero" do
    visit heroes_url
    click_on "Edit", match: :first

    fill_in "Badge template", with: @hero.badge_template_id
    fill_in "Country name", with: @hero.country_name
    fill_in "Recipient email", with: @hero.recipient_email
    fill_in "Expires at", with: @hero.expires_at
    fill_in "First name", with: @hero.first_name
    fill_in "Issued at", with: @hero.issued_at
    fill_in "Issuer earner", with: @hero.issuer_earner_id
    fill_in "Last name", with: @hero.last_name
    fill_in "Locale", with: @hero.locale
    fill_in "State or province", with: @hero.state_or_province
    check "Suppress badge notification email" if @hero.suppress_badge_notification_email
    click_on "Update Hero"

    assert_text "Hero was successfully updated"
    click_on "Back"
  end

  test "destroying a Hero" do
    visit heroes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Hero was successfully destroyed"
  end
end
