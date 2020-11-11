RSpec.describe SolidusTracking::Event::Base do
  describe '.payload_serializer' do
    context 'when the event does not have a payload serializer but the parent does' do
      it "returns the parent's payload serializer" do
        stub_const('ParentSerializer', Class.new(SolidusTracking::Serializer::Base))
        stub_const('ParentEvent', Class.new(described_class) do
          self.payload_serializer = 'ParentSerializer'
        end)
        stub_const('ChildEvent', Class.new(ParentEvent))

        expect(ChildEvent.payload_serializer).to eq(ParentSerializer)
      end
    end

    context 'when both the event and the parent have a payload serializer' do
      it "returns the event's payload serializer" do
        stub_const('ParentSerializer', Class.new(SolidusTracking::Serializer::Base))
        stub_const('ParentEvent', Class.new(described_class) do
          self.payload_serializer = 'ParentSerializer'
        end)
        stub_const('ChildSerializer', Class.new(SolidusTracking::Serializer::Base))
        stub_const('ChildEvent', Class.new(ParentEvent) do
          self.payload_serializer = 'ChildSerializer'
        end)

        expect(ChildEvent.payload_serializer).to eq(ChildSerializer)
      end
    end
  end

  describe '.customer_properties_serializer' do
    context 'when the event does not have a customer properties serializer but the parent does' do
      it "returns the parent's customer properties serializer" do
        stub_const('ParentSerializer', Class.new(SolidusTracking::Serializer::Base))
        stub_const('ParentEvent', Class.new(described_class) do
          self.customer_properties_serializer = 'ParentSerializer'
        end)
        stub_const('ChildEvent', Class.new(ParentEvent))

        expect(ChildEvent.customer_properties_serializer).to eq(ParentSerializer)
      end
    end

    context 'when both the event and the parent have a customer properties serializer' do
      it "returns the event's customer properties serializer" do
        stub_const('ParentSerializer', Class.new(SolidusTracking::Serializer::Base))
        stub_const('ParentEvent', Class.new(described_class) do
          self.customer_properties_serializer = 'ParentSerializer'
        end)
        stub_const('ChildSerializer', Class.new(SolidusTracking::Serializer::Base))
        stub_const('ChildEvent', Class.new(ParentEvent) do
          self.customer_properties_serializer = 'ChildSerializer'
        end)

        expect(ChildEvent.customer_properties_serializer).to eq(ChildSerializer)
      end
    end

    context 'when nor the event nor the parent have a customer properties serializer' do
      it "returns the default customer properties serializer" do
        stub_const('ParentEvent', Class.new(described_class))
        stub_const('ChildEvent', Class.new(ParentEvent))

        expect(ChildEvent.customer_properties_serializer).to eq(SolidusTracking::Serializer::CustomerProperties)
      end
    end
  end
end
