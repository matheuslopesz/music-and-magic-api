require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url, as: :json
    assert_response :success
    assert_not_nil JSON.parse(response.body)
  end

  test "should get index with all posts" do
    get posts_url, as: :json
    assert_response :success
    posts = JSON.parse(response.body)
    assert posts.is_a?(Array)
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { 
        post: { 
          title: "Novo Post",
          summary: "Resumo do novo post",
          content: "Conteúdo completo do novo post",
          published_at: Time.current
        } 
      }, as: :json
    end

    assert_response :created
    post_data = JSON.parse(response.body)
    assert_equal "Novo Post", post_data["title"]
    assert_equal "novo-post", post_data["slug"]
  end

  test "should create post and generate slug automatically" do
    assert_difference("Post.count") do
      post posts_url, params: { 
        post: { 
          title: "Post com Slug Automático",
          summary: "Resumo",
          content: "Conteúdo"
        } 
      }, as: :json
    end

    assert_response :created
    post_data = JSON.parse(response.body)
    assert_equal "post-com-slug-automatico", post_data["slug"]
  end

  test "should show post" do
    get post_url(@post), as: :json
    assert_response :success
    post_data = JSON.parse(response.body)
    assert_equal @post.title, post_data["title"]
    assert_equal @post.slug, post_data["slug"]
  end

  test "should update post" do
    patch post_url(@post), params: { 
      post: { 
        title: "Título Atualizado",
        content: @post.content,
        summary: @post.summary
      } 
    }, as: :json
    
    assert_response :success
    post_data = JSON.parse(response.body)
    assert_equal "Título Atualizado", post_data["title"]
  end

  test "should update post and regenerate slug when title changes" do
    original_slug = @post.slug
    patch post_url(@post), params: { 
      post: { 
        title: "Novo Título Diferente",
        content: @post.content,
        summary: @post.summary
      } 
    }, as: :json
    
    assert_response :success
    @post.reload
    assert_not_equal original_slug, @post.slug
    assert_equal "novo-titulo-diferente", @post.slug
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post), as: :json
    end

    assert_response :no_content
  end

  test "should return 404 when post not found" do
    get "/posts/99999", as: :json
    assert_response :not_found
  end
end
