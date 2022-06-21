# frozen_string_literal: true

RSpec.shared_examples "destroy record" do
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
        'recordId' => make_global_id(object)
      }
    }
  end

  it 'deletes user' do
    expect { result }.to change { object_class.count }.by(-1)
  end
end