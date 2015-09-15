require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { app_name: @event.app_name, domain: @event.domain, duration: @event.duration, end_time_stamp: @event.end_time_stamp, search_words: @event.search_words, start_time_stamp: @event.start_time_stamp, tenant: @event.tenant, url: @event.url, user_id: @event.user_id, user_type: @event.user_type }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { app_name: @event.app_name, domain: @event.domain, duration: @event.duration, end_time_stamp: @event.end_time_stamp, search_words: @event.search_words, start_time_stamp: @event.start_time_stamp, tenant: @event.tenant, url: @event.url, user_id: @event.user_id, user_type: @event.user_type }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
