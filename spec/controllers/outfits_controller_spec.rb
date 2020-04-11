require 'rails_helper'

describe OutfitsController do

  let(:outfits) { create_list(:outfit, 3, user: user) }
  let(:user) { create(:user) }

  describe 'GET #index' do

    context "ログインしている場合" do

      before do
        login user
      end
      
      it "@outfitsに正しい値が入っていること" do
        get :index
        expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
      end
  
      it "index.html.erbに遷移すること" do
        get :index
        expect(response).to render_template :index
      end

      it "@outfitに正しい値が入っていること" do
        get :index
        expect(assigns(:outfit)).to be_a_new(Outfit)
      end
      
    end
    
    context "ログインしていない場合" do
      
      it "トップページにリダイレクトすること" do
        get :index
        expect(response).to redirect_to(root_path)
      end

    end
  end

  describe 'post #create' do

    let(:params) { { user_id: user.id, outfit: attributes_for(:outfit) } }

    context "ログインしている場合" do

      before do
        login user
      end

      context "保存に成功した場合" do

        subject {
          post :create,
          params: params
        }
        
        it 'outfitを保存すること' do
          expect{ subject }.to change(Outfit, :count).by(1)
        end
        
        it "index.html.erbにリダイレクトすること" do
          subject
          expect(response).to redirect_to(outfits_path)
        end
        
      end
      
      context "保存に失敗した場合" do
        
        let(:invalid_params) { { user_id: user.id, outfit: attributes_for(:outfit, image: "") } }

        subject {
          post :create,
          params: invalid_params
        }

        it "outfitが保存されないこと" do
          expect{ subject }.not_to change(Outfit, :count)
        end

        it "index.html.erbにリダイレクトすること" do
          subject
          expect(response).to render_template :index
        end
        
        it "@outfitsに正しい値が入っていること" do
          subject
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

  describe 'delete #destroy' do

    let(:params) { { id: create(:outfit, user: user).id} }

    context "ログインしている場合" do


      before do
        login user
      end

      context "削除に成功した場合" do

        subject {
          delete :destroy,
          params: params
        }
        
        it "outfitを削除すること" do
          expect{ subject }.to change(Outfit, :count).by(0)
        end

        it "index.html.erbにリダイレクトすること" do
          subject
          expect(response).to redirect_to(outfits_path)
        end


      end

      context "削除に失敗した場合" do

        let(:invalid_params) { { id: create(:outfit).id } }

        subject {
          delete :destroy,
          params: invalid_params
        }

        it "outfitが削除されないこと" do
          expect{ subject }.to change(Outfit, :count).by(1)
        end

        it "index.html.erbにリダイレクトすること" do
          subject
          expect(response).to redirect_to(outfits_path)
        end

        it "@outfitsに正しい値が入っていること" do
          subject
          expect(assigns(:outfits)).to match(outfits.sort{|a, b| b.created_at <=> a.created_at })
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