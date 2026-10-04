-- Catálogo inicial; níveis sugeridos devem ser revisados pelo proprietário.
INSERT INTO skill_category (name, slug, description) VALUES
    ('Backend', 'backend', 'Desenvolvimento backend.'),
    ('Frontend', 'frontend', 'Desenvolvimento frontend.'),
    ('Database', 'database', 'Persistência e bancos de dados.'),
    ('Architecture', 'architecture', 'Arquitetura e padrões de sistemas.'),
    ('DevOps', 'devops', 'Infraestrutura, entrega e automação.'),
    ('Testing', 'testing', 'Testes de software.'),
    ('Cloud', 'cloud', 'Computação em nuvem.');

INSERT INTO skill (category_id, name, slug, description, proficiency) VALUES
    ((SELECT id FROM skill_category WHERE slug = 'backend'), 'Java', 'java', 'Desenvolvimento backend com Java.', 'ADVANCED'),
    ((SELECT id FROM skill_category WHERE slug = 'backend'), 'Spring Boot', 'spring-boot', 'Aplicações e APIs com Spring Boot.', 'ADVANCED'),
    ((SELECT id FROM skill_category WHERE slug = 'frontend'), 'Angular', 'angular', 'Aplicações web com Angular.', 'ADVANCED'),
    ((SELECT id FROM skill_category WHERE slug = 'frontend'), 'TypeScript', 'typescript', 'Desenvolvimento com TypeScript.', 'ADVANCED'),
    ((SELECT id FROM skill_category WHERE slug = 'database'), 'PostgreSQL', 'postgresql', 'Banco de dados relacional PostgreSQL.', 'INTERMEDIATE'),
    ((SELECT id FROM skill_category WHERE slug = 'architecture'), 'REST API', 'rest-api', 'Projeto e desenvolvimento de APIs REST.', 'ADVANCED'),
    ((SELECT id FROM skill_category WHERE slug = 'architecture'), 'Microservices', 'microservices', 'Serviços independentes e comunicação entre serviços.', 'INTERMEDIATE'),
    ((SELECT id FROM skill_category WHERE slug = 'devops'), 'Docker', 'docker', 'Containerização de aplicações e serviços.', 'INTERMEDIATE');
