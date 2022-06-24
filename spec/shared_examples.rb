# frozen_string_literal: true

RSpec.shared_examples "destroy record" do |object_name|
  let(:factory_name) { object_name.to_sym }
  let!(:record) { create(factory_name) }
  let(:query) { <<~GRAPHQL }
    mutation DestroyRecord($input: DestroyRecordInput!) {
      destroyRecord(input: $input) {
        errors
      }
      }
  GRAPHQL

  let(:variables) do
    {
      'input' => {
        'recordId' => make_global_id(record)
      }
    }
  end

  it 'deletes user' do
    expect { result }.to change { record.class.count }.by(-1)
  end
end