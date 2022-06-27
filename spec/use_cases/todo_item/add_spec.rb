# frozen_string_literal: true

require 'rails_helper'
require_relative '../use_cases_helper'

RSpec.describe TodoItems::Add do
  subject { described_class.new(request_model: request_model) }

  describe '#perform!' do
    let(:response_model) { subject.perform! }

    context 'when given a valid request model' do
      let(:request_model) { { title: 'Catch up with Silicon Valley' } }

      it 'is successful' do
        expect(response_model.success?).to eq(true)
      end
    end

    context 'when given an invalid request model' do
      context 'because there is no title key' do
        let(:request_model) { {} }

        it 'is not successful' do
          expect(response_model.success?).to eq(false)
        end

        it 'includes a missing and blank title error message' do
          expect(response_model.errors).to include(':title is missing', ":title can't be blank") 
        end
      end

      context 'because the title is blank' do
        let(:request_model) { { title: '' } }

        it 'is not successful' do
          expect(response_model.success?).to eq(false)
        end

        it 'includes a blank title error message' do
          expect(response_model.errors).to include(":title can't be blank")
        end
      end
    end
  end
end
