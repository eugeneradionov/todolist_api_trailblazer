RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user_id: user.id) }
  let(:task) { FactoryBot.create(:task, project_id: project.id) }

  before(:each) do
    request.headers.merge!(user.create_new_auth_token)
  end

  describe 'GET #index' do
    let!(:comments) { FactoryBot.create_list(:comment, 2, task_id: task.id) }

    context 'HTTP Status 200 | OK' do
      it 'returns collection of Comments', :show_in_doc do
        get :index, params: { task_id: task.id }

        expect(response).to have_http_status 200
        expect(JSON.parse(response.body)['data'].size).to eq(comments.size)
        expect(response).to match_json_schema('v1/comments/index')
      end
    end
  end

  describe 'POST #create' do
    let(:valid_create_params) do
      {
        data: {
          attributes: {
            body: FFaker::Movie.unique.title,
            task_id: task.id
          }
        }
      }
    end

    let(:invalid_create_params) do
      {
        data: {
          attributes: {
            body: '',
            task_id: task.id
          }
        }
      }
    end

    context 'valid params' do
      context 'HTTP Status 201 | Created' do
        it 'increases number of comments', :show_in_doc do
          expect do
            post :create, params: { task_id: task.id, comment: valid_create_params, **valid_create_params }
          end.to change(Comment, :count).by 1

          expect(response).to have_http_status 201
          expect(response).to match_json_schema('v1/comments/create')
        end
      end
    end

    context 'invalid params' do
      it 'HTTP Status 422 | Unprocessable Entity', :show_in_doc do
        post :create, params: { task_id: task.id, comment: invalid_create_params, **invalid_create_params }

        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PATCH #update' do
    let(:valid_update_params) do
      {
        data: {
          attributes: {
            body: 'new comment message',
            task_id: task.id
          }
        }
      }
    end

    context 'valid params' do
      let(:comment) { FactoryBot.create(:comment, task_id: task.id) }

      it 'HTTP Status 201 | Created', :show_in_doc do
        patch :update, params: { id: comment.id, task_id: task.id, comment: valid_update_params, **valid_update_params }

        expect(response).to have_http_status 201
        expect(JSON.parse(response.body)['data']['attributes']['body']).to eq(valid_update_params[:data][:attributes][:body])
        expect(response).to match_json_schema('v1/comments/update')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { FactoryBot.create(:comment, task_id: task.id) }

    context 'HTTP Status 204' do
      it 'deletes task', :show_in_doc do
        expect do
          delete :destroy, params: { id: comment.id, task_id: task.id }
        end.to change(Comment, :count).by(-1)

        expect(response).to have_http_status 204
      end
    end
  end
end
