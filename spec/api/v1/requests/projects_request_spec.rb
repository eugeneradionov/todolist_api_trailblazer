RSpec.describe Api::V1::ProjectsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_params) do
    {
      data: {
        attributes: {
          name: 'Valid name'
        }
      }
    }
  end
  let(:invalid_params) do
    {
      data: {
        attributes: {
          name: ''
        }
      }
    }
  end

  context 'unauthorized User' do
    describe 'GET #index' do
      it 'HTTP 401 | Unauthorized' do
        get :index

        expect(response).to have_http_status(401)
      end
    end
  end

  context 'authorized User' do
    before(:each) do
      request.headers.merge!(user.create_new_auth_token)
    end

    describe 'GET #index' do
      context 'HTTP 200 | OK' do
        let!(:projects) { FactoryBot.create_list(:project, 5, user_id: user.id) }

        it 'returns collections of Projects', :show_in_doc do
          get :index, format: :json

          expect(response).to have_http_status(200)
          expect(response).to match_json_schema('v1/projects/index')
          expect(JSON.parse(response.body)['data'].size).to eq(projects.size)
        end
      end
    end

    describe 'POST #create' do
      context 'HTTP 201 | Created' do
        it 'creates a Project', :show_in_doc do
          expect do
            post :create, params: { user_id: user.id, project: valid_params, **valid_params }
          end.to change(Project, :count).by(1)

          expect(response).to have_http_status(201)
          expect(response).to match_json_schema('v1/projects/create')
        end
      end

      context 'HTTP 422 | Unprocessable Entity' do
        it 'returns errors', :show_in_doc do
          post :create, params: { user_id: user.id, project: invalid_params, **invalid_params }

          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['errors']).not_to be_blank
        end
      end
    end

    describe 'PATCH #update' do
      let(:project) { FactoryBot.create(:project, user_id: user.id) }

      context 'HTTP 201 | Created' do
        it 'updates a Project', :show_in_doc do
          patch :update, params: { id: project.id, user_id: user.id, project: valid_params, **valid_params }

          expect(JSON.parse(response.body)['data']['attributes']['name']).to eq(valid_params[:data][:attributes][:name])
          expect(response).to match_json_schema('v1/projects/update')
          expect(response).to have_http_status(201)
        end
      end

      context 'HTTP 422 | Unprocessable Entity' do
        it 'returns errors', :show_in_doc do
          patch :update, params: { id: project.id, user_id: user.id, project: invalid_params, **invalid_params }

          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['errors']).not_to be_blank
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:project) { FactoryBot.create(:project, user_id: user.id) }
      let(:valid_params) do
        {
          data: {
            attributes: {
              id: project.id
            }
          }
        }
      end

      context 'HTTP 204 | No Content' do
        it 'deletes a Project', :show_in_doc do
          expect do
            delete :destroy, params: { id: project.id, user_id: user.id, project: valid_params, **valid_params }
          end.to change(Project, :count).by(-1)
          expect(response).to have_http_status(204)
        end
      end
    end
  end
end
