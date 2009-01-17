require File.dirname(__FILE__) + "/spec_helper"
 
describe Integrity::Notifier::Growl do
  include AppSpecHelper
  include NotifierSpecHelper
  
  it_should_behave_like "A notifier"
  
  def klass
    Integrity::Notifier::Growl
  end
  
  describe "notifying the world of a build" do
    before { klass.stub!(:new).and_return(notifier) }

    it "should instantiate a notifier with the given build and config" do
      klass.should_receive(:new).with(mock_build, anything).and_return(notifier)
      klass.notify_of_build(mock_build, notifier_config)
    end

    it "should pass the notifier options to the notifier" do
      klass.should_receive(:new).with(anything, notifier_config).and_return(notifier)
      klass.notify_of_build(mock_build, notifier_config)
    end

    it "should deliver the notification" do
      notifier.should_receive(:deliver!)
      klass.notify_of_build(mock_build, notifier_config)
    end
  end
  
  describe "generating a form for configuration" do
      describe "with a field for the recipients" do
        it "should have the proper name, id and label" do
          the_form.should have_textfield("growl_notifier_addresses").named("notifiers[Growl][addresses]").with_label("Addresses").with_value(nil)
        end

        it "should use the config's ip value if available" do
          the_form(:config => { 'addresses' => '127.0.0.1' }).should have_textfield("growl_notifier_addresses").with_value("127.0.0.1")
        end
      end
    end
end