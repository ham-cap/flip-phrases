require 'rails_helper'

RSpec.describe "Cards", type: :system do
  before do
    @cards = []
    3.times do
      @cards << FactoryBot.create(:card)
    end
  end

  it 'display a list of cards' do
    visit cards_path
    expect(page).to have_content "Cards#index"
    expect(page).to have_content "こんにちは 10"
    expect(page).to have_content "こんにちは 11"
    expect(page).to have_content "こんにちは 12"
    expect(page).to have_content "Hello 8"
    expect(page).to have_content "Hello 9"
    expect(page).to have_content "Hello 10"
  end

  it 'creates a new card' do
    visit new_card_path
    expect(page).to have_content '新規作成'
    fill_in 'original_text', with: '本日は晴天なり'
    click_on '翻訳する'
    expect(page).to have_content 'Cards#index'
    expect(page).to have_content '本日は晴天なり'
    expect(page).to have_content 'testing a microphone'
  end

  it 'display a details page of cards' do
    card = FactoryBot.create(:card)

    visit card_path(card)
    expect(page).to have_content 'Cards#show'
    expect(page).to have_content 'こんにちは 19'
    expect(page).to have_content 'Hello 17'
  end

  it 'deletes a card', :js do
    card = FactoryBot.create(:card)

    visit card_path(card)
    accept_confirm "本当に削除しますか？" do
      click_on '削除する'
    end
    expect(page).to have_content 'Cards#index'
    expect(page).not_to have_content 'こんにちは 23'
    expect(page).not_to have_content 'Hello 21'
  end
end
