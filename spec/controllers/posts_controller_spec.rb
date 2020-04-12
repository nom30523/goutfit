require 'rails_helper'

describe PostsController do

  let(:user) { create(:user) }
  let(:outfit) { create(:outfit, user: user) }
  let(:outfits) { create_list(:outfit, 3, user: user)}
  let(:posts) { create_list(:post, 3, outfit_id: outfit.id, user: user)}

  describe 'GET #index' do
    
    context "ログインしている場合" do

      before do
        login user
      end

      it "index.html.erbに遷移すること" do
        get :index
        expect(response).to render_template :index
      end
      
      it "@postsに正しい値が入っていること" do
        get :index
        expect(assigns(:posts)).to match(posts)
      end
      
      it "@todayに正しい値が入っていること" do
        today = Date.current.strftime('%Y/%m/%d (%a)')
        get :index
        expect(assigns(:today)).to eq today
      end
            
      it "@postに正しい値が入っていること" do
        today = Date.current.strftime('%Y-%m-%d')
        post = create(:post, user: user, appointed_day: today)
        get :index
        expect(assigns(:post)).to eq post
      end
      
      it "@outfitに正しい値が入っていること" do
        today = Date.current.strftime('%Y-%m-%d')
        post = create(:post, user: user, appointed_day: today)
        outfit = Outfit.find(post.outfit_id)
        get :index
        expect(assigns(:outfit)).to eq outfit
      end
      
    end
    
    context "ログインしていない場合" do
      it "トップページが表示されること" do
        get :index
        expect(response).to render_template :index
      end
    end

  end

  describe 'GET #new' do

    context "ログインしている場合" do

      before do
        login user
      end

      it "@outfitsに正しい値が入っていること" do
        get :new
        expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
      end

      it "@postに正しい値が入っていること" do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "new.html.erbに遷移すること" do
        get :new
        expect(response).to render_template :new
      end

    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

  end

  describe 'POST #create' do

    let(:params) { { user_id: user.id, post: attributes_for(:post, outfit_id: outfit.id) } }

    context "ログインしている場合" do

      before do
        login user
      end

      context "本人の画像である場合" do

        context "保存に成功した場合" do

          subject {
            post :create,
            params: params
          }
  
          it "postを保存すること" do
            expect{ subject }.to change(Post, :count).by(1)
          end
  
          it "トップページにリダイレクトすること" do
            subject
            expect(response).to redirect_to(root_path)
          end
  
        end
  
        context "保存に失敗した場合" do
  
          let(:invalid_params) { { user_id: user.id, post: attributes_for(:post, outfit_id: outfit.id, appointed_day: nil) } }
  
          subject {
            post :create,
            params: invalid_params
          }
  
          it "postが保存されないこと" do
            expect{ subject }.not_to change(Post, :count)
          end
  
          it "new.html.erbに遷移すること" do
            subject
            expect(response).to render_template :new
          end
  
          it "@outfitsに正しい値が入っていること" do
            post :create,
            params: {
              user_id: user,
              post: attributes_for(:post, appointed_day: "")
            }
            expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
          end
  
        end
      end

      context "本人の画像でない場合" do

        let(:outfit) { create(:outfit)}
        let(:invalid_params) { { user_id: user.id, post: attributes_for(:post, outfit_id: outfit.id) } }

        subject {
          post :create,
          params: invalid_params
        }

        it "postが保存されないこと" do
          expect{ subject }.not_to change(Post, :count)
        end

        it "new.html.erbに遷移すること" do
          subject
          expect(response).to render_template :new
        end

        it "@outfitsに正しい値が入っていること" do
          post :create,
          params: {
            user_id: user,
            post: attributes_for(:post)
          }

          expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
        end

      end

    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        post :create, params: params
        expect(response).to redirect_to(root_path)
      end
    end

  end

  describe 'GET #edit' do

    let(:post) { create(:post, user: user) }
    let(:params) { { id: post } }

    context "ログインしている場合" do

      before do
        login user
      end

      context "本人のpostである場合" do
        it "@outfitsに正しい値が入っていること" do
          get :edit, params: params
          expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
        end
  
        it "@postに正しい値が入っていること" do
          get :edit, params: params
          expect(assigns(:post)).to eq post
        end
  
        it "edit.html.erbに遷移すること" do
          get :edit, params: params
          expect(response).to render_template :edit
        end
      end

      context "本人のpostでない場合" do
        it "トップページにリダイレクトすること" do
          post = create(:post)
          get :edit, params: { id: post }
          expect(response).to redirect_to(root_path)
        end
      end

    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get :edit, params: params
        expect(response).to redirect_to(root_path)
      end
    end

  end

  describe 'PATCH #update' do

    context "ログインしている場合" do
      
      before do
        login user
      end
      
      context "本人のpostである場合" do
                
        let(:post) { create(:post, user: user) }

        context "本人の画像である場合" do
          
          let(:params) { { id: post, post: attributes_for(:post, outfit_id: outfit.id) } }

          context "更新に成功した場合" do

            subject {
              patch :update,
              params: params
            }
  
            it "データベースのpostが更新されること" do
              subject
              expect(post.reload.outfit_id).to eq outfit.id
            end
  
            it "トップページにリダイレクトすること" do
              subject
              expect(response).to redirect_to(root_path)
            end

          end
  
          context "更新に失敗した場合" do

            let(:invalid_params) { { id: post, post: attributes_for(:post, outfit_id: outfit.id, appointed_day: nil) } }

            subject {
              patch :update,
              params: invalid_params
            }

            it "データベースのpostが更新されないこと" do
              old_outfit = post.outfit_id
              subject
              expect(post.reload.outfit_id).to eq old_outfit
            end

            it "edit.html.erbに遷移すること" do
              subject
              expect(response).to render_template :edit
            end

            it "@outfitsに正しい値が入っていること" do
              patch :update,
              params: {
                id: post,
                post: attributes_for(:post, appointed_day: nil)
              }
              expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
            end

          end

        end

        context "本人の画像でない場合" do

          let(:outfit) { create(:outfit) }
          let(:invalid_params) { { id: post, post: attributes_for(:post, outfit_id: outfit.id) } }

          subject {
            patch :update,
            params: invalid_params
          }

          it "データベースのpostが更新されないこと" do
            old_outfit = post.outfit_id
            subject
            expect(post.reload.outfit_id).to eq old_outfit
          end

          it "edit.html.erbに遷移すること" do
            subject
            expect(response).to render_template :edit
          end

          it "@outfitsに正しい値が入っていること" do
            patch :update,
            params: {
              id: post,
              post: attributes_for(:post, appointed_day: nil)
            }
            expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
          end

        end

      end

      context "本人のpostでない場合" do

        let(:post) { create(:post) }
        let(:params) { { id: post, post: attributes_for(:post, outfit_id: outfit.id) } }

        subject {
          patch :update,
          params: params
        }

        it "トップページにリダイレクトすること" do
          subject
          expect(response).to redirect_to(root_path)
        end
        
      end
      
    end
    
    context "ログインしていない場合" do

      let(:post) { create(:post, user: user) }
      let(:params) { { id: post, post: attributes_for(:post, outfit_id: outfit.id) } }

      subject {
        patch :update,
        params: params
      }

      it "トップページにリダイレクトすること" do
        subject
        expect(response).to redirect_to(root_path)
      end

    end

  end

  describe 'DELETE #destroy' do

    let(:post) { create(:post, user: user) }
    let(:params) { { id: post } }

    context "ログインしている場合" do

      before do
        login user
      end

      context "本人のpostである場合" do

        subject {
          delete :destroy,
          params: params
        }

        it "postが削除されること" do
          expect{ subject }.to change(Post, :count).by(0)
        end

        it "トップページにリダイレクトすること" do
          subject
          expect(response).to redirect_to(root_path)
        end

      end

      context "本人のpostではない場合" do

        let(:post) { create(:post) }
        let(:invalid_params) { { id: post } }

        subject {
          delete :destroy,
          params: invalid_params
        }

        it "postが削除されないこと" do
          expect{ subject }.to change(Post, :count).by(1)
        end

        it "トップページにリダイレクトすること" do
          subject
          expect(response).to redirect_to(root_path)
        end

      end

    end

    context "ログインしていない場合" do

      it "トップページにリダイレクトすること" do
        delete :destroy, params: params
        expect(response).to redirect_to(root_path)
      end

    end

  end

end
