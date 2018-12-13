RSpec.describe Api::V1::TasksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user_id: user.id) }
  let!(:tasks) { FactoryBot.create_list(:task, 5, project_id: project.id) }
  let(:task) { tasks.sample }

  before(:each) do
    request.headers.merge!(user.create_new_auth_token)
  end

  describe 'GET #index' do
    context 'HTTP Status 200 | OK' do
      it 'returns collection of Tasks', :show_in_doc do
        get :index, params: { project_id: project.id }

        expect(response).to have_http_status 200
        expect(JSON.parse(response.body)['data'].size).to eq(tasks.size)
        expect(response).to match_json_schema('v1/tasks/index')
      end
    end
  end

  describe 'POST #create' do
    let(:valid_create_params) do
      {
        data: {
          attributes: {
            name: FFaker::Movie.unique.title,
            project_id: project.id,
            deadline: Time.zone.tomorrow
          }
        }
      }
    end

    let(:invalid_create_params) do
      {
        data: {
          attributes: {
            name: '',
            deadline: Time.zone.yesterday,
            project_id: project.id
          }
        }
      }
    end

    context 'valid params' do
      context 'HTTP Status 201 | Created' do
        it 'increases number of tasks', :show_in_doc do
          expect do
            post :create, params: { project_id: project.id, task: valid_create_params, **valid_create_params }
          end.to change(Task, :count).by 1

          expect(response).to have_http_status 201
          expect(response).to match_json_schema('v1/tasks/create')
        end
      end
    end

    context 'invalid params' do
      it 'HTTP Status 422 | Unprocessable Entity', :show_in_doc do
        post :create, params: { project_id: project.id, task: invalid_create_params, **invalid_create_params }

        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PATCH #update' do
    let(:valid_update_params) do
      {
        data: {
          attributes: {
            name: 'New awesome name',
            done: true,
            deadline: Time.zone.tomorrow,
            project_id: project.id
          }
        }
      }
    end

    context 'valid params' do
      it 'HTTP Status 201 | Created', :show_in_doc do
        patch :update, params: { id: task.id, task: valid_update_params, project_id: project.id, **valid_update_params }

        expect(response).to have_http_status 201
        expect(JSON.parse(response.body)['data']['attributes']['name']).to eq(valid_update_params[:data][:attributes][:name])
        expect(response).to match_json_schema('v1/tasks/update')
      end
    end
  end

  describe 'PATCH #position' do
    let(:valid_position_params) do
      {
        data: {
          attributes: {
            position: task.position + 1
          }
        }
      }
    end

    it 'HTTP Status 201' do
      patch :position, params: { id: task.id, task: valid_position_params, **valid_position_params }

      expect(response).to have_http_status 201
      expect(JSON.parse(response.body)['data']['attributes']['position']).to eq(valid_position_params[:data][:attributes][:position])
      expect(response).to match_json_schema('v1/tasks/position')
    end
  end

  describe 'PATCH #complete' do
    it 'HTTP Status 201' do
      patch :complete, params: { id: task.id }

      expect(response).to have_http_status 201
      expect(JSON.parse(response.body)['data']['attributes']['done']).to eq(true)
      expect(response).to match_json_schema('v1/tasks/complete')
    end
  end

  describe 'DELETE #destroy' do
    context 'HTTP Status 204' do
      it 'deletes task', :show_in_doc do
        expect do
          delete :destroy, params: { id: task.id }
        end.to change(Task, :count).by(-1)

        expect(response).to have_http_status 204
      end
    end
  end
end
