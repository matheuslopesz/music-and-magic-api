require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should generate slug from title" do
    post = Post.new(title: "Meu Primeiro Post")
    post.save
    assert_equal "meu-primeiro-post", post.slug
  end

  test "should generate unique slug when title has special characters" do
    post = Post.new(title: "Post com Acentos & Caracteres Especiais!")
    post.save
    assert_equal "post-com-acentos-caracteres-especiais", post.slug
  end

  test "should update slug when title changes" do
    post = Post.create!(title: "Título Original")
    original_slug = post.slug
    
    post.update(title: "Título Atualizado")
    assert_not_equal original_slug, post.slug
    assert_equal "titulo-atualizado", post.slug
  end

  test "should not update slug when title does not change" do
    post = Post.create!(title: "Título Fixo")
    original_slug = post.slug
    
    post.update(content: "Novo conteúdo")
    assert_equal original_slug, post.slug
  end

  test "should create post with all attributes" do
    post = Post.new(
      title: "Test Post",
      summary: "This is a summary",
      content: "This is the full content",
      published_at: Time.current
    )
    
    assert post.save
    assert_equal "test-post", post.slug
    assert_equal "Test Post", post.title
    assert_equal "This is a summary", post.summary
    assert_equal "This is the full content", post.content
  end

  test "should find post by friendly id" do
    post = Post.create!(title: "Post para Buscar")
    found_post = Post.friendly.find("post-para-buscar")
    
    assert_equal post.id, found_post.id
  end

  test "should handle multiple words in title for slug generation" do
    post = Post.create!(title: "Este é um Post com Múltiplas Palavras")
    assert_equal "este-e-um-post-com-multiplas-palavras", post.slug
  end
end
