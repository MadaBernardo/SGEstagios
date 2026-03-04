\# 🎓 Internship Management System (SGE) | SQL Server



> \*\*Note:\*\* \[Clique aqui para ler a versão em Português](#versão-em-português)



A professional-grade relational database solution developed for the \*\*Database Systems II\*\* course. This system automates the management of curricular internships for the company \*\*Improve You\*\*, handling the entire lifecycle from job posting to student placement with full auditability and data integrity.



---



\## 🛠️ Technologies Used



\* \*\*RDBMS:\*\* Microsoft SQL Server (2022+)

\* \*\*Language:\*\* T-SQL (Stored Procedures, Triggers, Views, Functions)

\* \*\*Design Tool:\*\* SQL Server Management Studio (SSMS), Draw.io

\* \*\*Versioning:\*\* Git \& GitHub



---



\## 🚀 Key Features



\* \*\*Job Cycle Management:\*\* Complete workflow for creating, listing, and closing internship offers.

\* \*\*Automated Application Tracking:\*\* Real-time status updates (PENDING, ACCEPTED, REJECTED).

\* \*\*Smart Vacancy Control:\*\* Automatic decrement/increment of available slots based on accepted students.

\* \*\*Data Guard:\*\* Triggers that block applications for closed, full, or expired vacancies.

\* \*\*Role-Based Security:\*\* Implementation of custom Database Roles for specialized access.



---



\## 📊 Data Architecture



\### Entity-Relationship Diagram (ERD)



!\[Database Diagram](./Database/diagramSGE.png)

\*The architecture consists of 8 interconnected tables designed to minimize redundancy and ensure referential integrity.\*



\### Relational Schema Highlights

\* \*\*Main Entities:\*\* `Empresa`, `Aluno`, `Oferta\_Estagio`, `Candidatura`, `Curso`.

\* \*\*Auditory Support:\*\* `Historico\_Candidatura` (Tracks every state change).



---



\## 🧠 Advanced SQL Features



The project leverages advanced T-SQL objects to ensure business logic is handled at the database level.



\### 1. Stored Procedures (Business Logic)

I developed \*\*7 specialized procedures\*\* to handle operations and reporting:

\* `SP\_ListarOfertasAtivas`: Filters available jobs based on date, status, and vacancy count.

\* `SP\_CriarOfertaEstagio`: Validates company status before allowing new postings.

\* `SP\_EstagiosComMaisProcura`: Ranking system to identify jobs with the highest application volume.

\* `SP\_ListarCandidaturasPorEmpresa`: Facilitates the recruiter's view of incoming candidates.

\* `SP\_AtualizarEstadoCandidatura`: Safely modifies application statuses.

\* `SP\_EstatisticasGerais`: A management dashboard providing real-time KPIs (Total Students, Acceptance Rates, etc.).

\* `SP\_ListarCandidaturasPorAluno`: Individual tracking for student users.



\### 2. Triggers (Automated Integrity)

\*\*4 Triggers\*\* act as background "police" to maintain data consistency:

\* `trg\_GerirVagasOcupadas`: Automatically updates `Vagas\_Ocupadas` whenever a student is accepted or removed.

\* `trg\_LogHistorico`: Captures state changes and saves them to the Audit table automatically.

\* `trg\_ValidarCandidatura`: \*\*Critical Security:\*\* Blocks any application attempted on full or expired offers.

\* `trg\_FecharCandidaturasPendentes`: When a job is closed, it automatically sets all pending applications to REJECTED.



\### 3. Views (Data Abstraction)

\* `vw\_EmpresasAtivas`: Security layer to hide inactive partners.

\* `vw\_AlunosAtivos`: Filters out students who have dropped out or finished their course.



---



\## ⚙️ Setup \& Usage



\### 1. Installation

-- Clone the repository and run the main script in your SSMS:

```bash

git clone https://github.com/MadaBernardo/SGEstagios.git

-- Execute: database/sistema-gestão-ofertas.sql.



\### 2. Testing the Logic

You can test the automated features by running these commands:



SQL

-- Create a new offer (Automated validation)

EXEC SP\_CriarOfertaEstagio 1, 'Multimedia', 'Final Defense Test', 2, '2026-12-31';



-- Update an application (Triggers audit and vacancy count)

EXEC SP\_AtualizarEstadoCandidatura @Id\_Candidatura = 12, @NovoEstado = 'RECUSADO', @OBS = 'TESTEADMIN';



-- View Real-time Stats

EXEC SP\_EstatisticasGerais;



---



\## 📄 License \& Credits



\* \*\*Developed by:\*\* Madalena Bernardo.

\* \*\*License:\*\* Licensed under the \[MIT License](LICENSE).

\* \*\*Project Type: Semester Project for Database Systems II.



---



\## Versão em Português



\# 🎓 Sistema de Gestão de Estágios (SGE) | SQL Server



Uma solução de banco de dados relacional de nível profissional desenvolvida para a disciplina \*\*Sistemas de Banco de Dados II\*\*. Este sistema automatiza a gestão de estágios curriculares para a empresa \*\*Improve You\*\*, gerenciando todo o ciclo de vida, desde a publicação da vaga até a alocação do estudante, com total auditabilidade e integridade dos dados.



---



\## 🛠️ Tecnologias Utilizadas



\* \*\*SGBDR:\*\* Microsoft SQL Server (2022+)

\* \*\*Linguagem:\*\* T-SQL (Stored Procedures, Triggers, Views, Functions)

\* \*\*Ferramenta de Design:\*\* SQL Server Management Studio (SSMS), Draw.io

\* \*\*Controle de Versão:\*\* Git e GitHub



---



\## 🚀 Principais Funcionalidades



\* \*\*Gestão do Ciclo de Estágio:\*\* Fluxo de trabalho completo para criação, publicação e encerramento de ofertas de estágio.

\* \*\*Rastreamento Automatizado de Candidaturas:\*\* Atualizações de status em tempo real (PENDENTE, ACEITO, REJEITADO).



\* \*\*Controle Inteligente de Vagas:\*\* Diminuição/aumento automático do número de vagas disponíveis com base nos alunos aceitos.



\* \*\*Proteção de Dados:\*\* Gatilhos que bloqueiam candidaturas para vagas fechadas, preenchidas ou expiradas.



\* \*\*Segurança Baseada em Funções:\*\* Implementação de Funções de Banco de Dados personalizadas para acesso especializado.



---



\## 📊 Arquitetura de Dados



\### Diagrama Entidade-Relacionamento (DER)



!\[Database Diagram](./Database/diagramSGE.png)

\*A arquitetura consiste em 8 tabelas interconectadas, projetadas para minimizar a redundância e garantir a integridade referencial.\*



\### Destaques do Esquema Relacional

\* \*\*Entidades Principais:\*\* `Empresa`, `Aluno`, `Oferta\_Estagio`, `Candidatura`, `Curso`.



\* \*\*Suporte de Auditoria:\*\* `Historico\_Candidatura` (Rastreia cada mudança de estado).



---



\## 🧠Recursos Avançados de SQL



O projeto utiliza objetos T-SQL avançados para garantir que a lógica de negócios seja tratada no nível do banco de dados.



\### 1. Procedimentos Armazenados (Lógica de Negócios)

Desenvolvi \*\*7 procedimentos especializados\*\* para lidar com operações e relatórios:

\* `SP\_ListarOfertasAtivas`: Filtra vagas disponíveis com base em data, status e número de vagas.



\* `SP\_CriarOfertaEstagio`: Valida o status da empresa antes de novas publicações.



\* `SP\_EstagiosComMaisProcura`: Sistema de classificação para identificar vagas com o maior volume de candidaturas.



\* `SP\_ListarCandidaturasPorEmpresa`: Facilita a visualização dos candidatos recebidos pelo recrutador.



\* `SP\_AtualizarEstadoCandidatura`: Modifica os status das candidaturas com segurança.



\* `SP\_EstatisticasGerais`: Um painel de gestão que fornece KPIs em tempo real (Total de Alunos, Taxas de Aceitação, etc.).

\* `SP\_ListarCandidaturasPorAluno`: Rastreamento individual para usuários estudantes.



\### 2. Gatilhos (Integridade Automatizada)

\*\*4 Gatilhos\*\* atuam como "polícia" em segundo plano para manter a consistência dos dados:

\* `trg\_GerirVagasOcupadas`: Atualiza automaticamente `Vagas\_Ocupadas` sempre que um aluno é aceito ou removido.



\* `trg\_LogHistorico`: Captura as alterações de estado e as salva automaticamente na tabela de Auditoria.



\* `trg\_ValidarCandidatura`: \*\*Segurança Crítica:\*\* Bloqueia qualquer tentativa de candidatura com ofertas preenchidas ou expiradas.



\* `trg\_FecharCandidaturasPendentes`: Quando uma vaga é fechada, define automaticamente todas as candidaturas pendentes como REJEITADAS.



\### 3. Visualizações (Abstração de Dados)

\* `vw\_EmpresasAtivas`: Camada de segurança para ocultar parceiros inativos.



\* `vw\_AlunosAtivos`: Filtra alunos que desistiram ou concluíram o curso.



---



\## ⚙️ Configuração e Uso



\### 1. Instalação

-- Clone o repositório e execute o script principal no seu SSMS:

```bash

git clone https://github.com/MadaBernardo/SGEstagios.git

-- Execute: database/sistema-gestão-ofertas.sql.



\### 2. Testando a Lógica

Você pode testar os recursos automatizados executando estes comandos:



SQL

-- Criar uma nova oferta (Validação automatizada)

EXEC SP\_CriarOfertaEstagio 1, 'Multimedia', 'Final Defense Test', 2, '2026-12-31';



\- Atualizar uma inscrição (aciona auditoria e contagem de vagas)

EXEC SP\_AtualizarEstadoCandidatura @Id\_Candidatura = 12, @NovoEstado = 'RECUSADO', @OBS = 'TESTEADMIN';



\- Ver estatísticas em tempo real

EXEC SP\_EstatísticasGerais;



---



\## 📄 Licença e Créditos



\* \*\*Desenvolvido por:\*\* Madalena Bernardo.

\* \*\*Licença:\*\* Licenciado sob a \[\[MIT License](LICENSE).

\* \*\*Tipo de Projeto: Projeto Semestral de Sistemas de Banco de Dados II.





