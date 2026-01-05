# Music and Magic API

Uma API REST desenvolvida em Ruby on Rails para servir um blog sobre música e magia.

## 📋 Sobre o Projeto

Esta é uma API JSON-only construída com Rails 7.2.3 que fornece endpoints para gerenciar posts de blog. A API utiliza FriendlyId para gerar URLs amigáveis (slugs) automaticamente a partir dos títulos dos posts.

## 🚀 Tecnologias

- **Ruby** 3.3.0
- **Rails** 7.2.3
- **PostgreSQL** 14
- **Docker** & Docker Compose
- **FriendlyId** - URLs amigáveis
- **Rack CORS** - Suporte a requisições cross-origin
- **Minitest** - Framework de testes

## 📦 Pré-requisitos

- Docker e Docker Compose instalados
- Git

## 🛠️ Instalação

1. Clone o repositório:
```bash
git clone git@github.com:matheuslopesz/music-and-magic-api.git
cd music-and-magic-api
```

2. Inicie os containers:
```bash
docker-compose up -d --build
```

3. Crie e configure o banco de dados:
```bash
docker-compose exec api rails db:create
docker-compose exec api rails db:migrate
```

4. (Opcional) Popule o banco com dados iniciais:
```bash
docker-compose exec api rails db:seed
```

## ▶️ Como Executar

### Iniciar a aplicação
```bash
docker-compose up
```

A API estará disponível em: `http://localhost:3001`

### Parar a aplicação
```bash
docker-compose down
```

### Ver logs
```bash
docker-compose logs -f api
```

### Acessar o console do Rails
```bash
docker-compose exec api rails console
```

## 📡 Endpoints da API

### Posts

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/posts` | Lista todos os posts |
| GET | `/posts/:id` ou `/posts/:slug` | Exibe um post específico |
| POST | `/posts` | Cria um novo post |
| PATCH/PUT | `/posts/:id` ou `/posts/:slug` | Atualiza um post |
| DELETE | `/posts/:id` ou `/posts/:slug` | Remove um post |

### Health Check

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/up` | Verifica se a aplicação está rodando |

## 📝 Exemplos de Uso

### Criar um post
```bash
curl -X POST http://localhost:3001/posts \
  -H "Content-Type: application/json" \
  -d '{
    "post": {
      "title": "Meu Primeiro Post",
      "summary": "Este é um resumo do post",
      "content": "Este é o conteúdo completo do post",
      "published_at": "2026-01-05T12:00:00Z"
    }
  }'
```

### Listar posts
```bash
curl http://localhost:3001/posts
```

### Buscar post por slug
```bash
curl http://localhost:3001/posts/meu-primeiro-post
```

### Atualizar um post
```bash
curl -X PATCH http://localhost:3001/posts/meu-primeiro-post \
  -H "Content-Type: application/json" \
  -d '{
    "post": {
      "title": "Título Atualizado",
      "content": "Conteúdo atualizado"
    }
  }'
```

### Deletar um post
```bash
curl -X DELETE http://localhost:3001/posts/meu-primeiro-post
```

## 🧪 Testes

Execute a suíte de testes:
```bash
docker-compose exec api rails test
```

Execute testes específicos:
```bash
# Testes do model
docker-compose exec api rails test test/models/post_test.rb

# Testes do controller
docker-compose exec api rails test test/controllers/posts_controller_test.rb
```

## 🗄️ Estrutura do Banco de Dados

### Tabela `posts`

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | integer | Chave primária |
| title | string | Título do post |
| summary | string | Resumo do post |
| content | text | Conteúdo completo |
| published_at | datetime | Data de publicação |
| slug | string | URL amigável (gerada automaticamente) |
| created_at | datetime | Data de criação |
| updated_at | datetime | Data de atualização |

## 🔧 Configuração

### Variáveis de Ambiente

As seguintes variáveis podem ser configuradas no `docker-compose.yml`:

- `POSTGRES_PASSWORD`: Senha do PostgreSQL
- `POSTGRES_USER`: Usuário do PostgreSQL
- `POSTGRES_HOST`: Host do PostgreSQL
- `RAILS_ENV`: Ambiente Rails (development, test, production)
- `SECRET_KEY_BASE`: Chave secreta do Rails

### CORS

A API está configurada para aceitar requisições de qualquer origem em desenvolvimento. **IMPORTANTE**: Em produção, configure o CORS no arquivo `config/initializers/cors.rb` para permitir apenas o domínio do seu frontend.

## 📁 Estrutura do Projeto

```
music-and-magic-api/
├── app/
│   ├── controllers/
│   │   └── posts_controller.rb
│   └── models/
│       └── post.rb
├── config/
│   ├── database.yml
│   ├── routes.rb
│   └── initializers/
│       ├── cors.rb
│       └── friendly_id.rb
├── db/
│   ├── migrate/
│   └── seeds.rb
├── test/
│   ├── controllers/
│   ├── models/
│   └── fixtures/
├── docker-compose.yml
├── Dockerfile
└── Gemfile
```

## 🐳 Docker

O projeto utiliza Docker Compose para facilitar o desenvolvimento. Os serviços incluem:

- **api**: Container da aplicação Rails
- **db**: Container do PostgreSQL

### Comandos Úteis

```bash
# Reconstruir containers
docker-compose up -d --build

# Reiniciar serviços
docker-compose restart

# Ver status dos containers
docker-compose ps

# Executar comandos Rails
docker-compose exec api rails <comando>

# Acessar bash do container
docker-compose exec api bash
```

## 🔒 Segurança

- A API utiliza strong parameters para proteger contra mass assignment
- CORS configurado (ajuste para produção)
- Validações de dados no modelo
- Prepared statements para prevenir SQL injection

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👤 Autor

**Matheus Lopes**

- GitHub: [@matheuslopesz](https://github.com/matheuslopesz)

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request.

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📚 Recursos Adicionais

- [Documentação do Rails](https://guides.rubyonrails.org/)
- [FriendlyId Documentation](https://github.com/norman/friendly_id)
- [Docker Documentation](https://docs.docker.com/)

---

Desenvolvido com ❤️ usando Ruby on Rails
