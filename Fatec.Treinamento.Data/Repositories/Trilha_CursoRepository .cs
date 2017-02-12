using Fatec.Treinamento.Data.Repositories.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Fatec.Treinamento.Model;
using Fatec.Treinamento.Data.Repositories.Base;
using Dapper;
using Fatec.Treinamento.Model.DTO;

namespace Fatec.Treinamento.Data.Repositories
{
    public class Trilha_CursoRepository: RepositoryBase, ITrilha_CursoRepository
    {
        public Trilha_Curso  Inserir(Trilha_Curso trilha_curso)
        {
            var id = Connection.ExecuteScalar<int>(
                   @"INSERT INTO Trilha_Curso (IdTrilha,IdCurso) 
                 VALUES (@IdTrilha,@IdCurso) 
               SELECT SCOPE_IDENTITY()",
                   param: new
                   {
                       trilha_curso.IdTrilha,
                       trilha_curso.IdCurso,
                   }
               );
            return trilha_curso;
        }

        public IEnumerable<Curso> ListarCursos()
        {
            return Connection.Query<Curso>(
              @"SELECT
	                c.Id,
	                c.Nome,
	                a.Nome as Assunto,
	                u.Nome as Autor,
	                c.DataCriacao,
	                c.Classificacao
                 FROM curso c
                 inner join assunto a on c.IdAssunto = a.id
                 inner join usuario u on c.IdAutor = u.Id
                 ORDER BY c.Nome"
            ).ToList();
        }
        public Capitulo Atualizar(Capitulo capitulo)
        {
            Connection.Execute(
               @"UPDATE Capitulo SET 
                    Nome = @Nome
                WHERE Id = @Id",
               param: new
               {
                   capitulo.Nome,
                   capitulo.Id
               }
            );

            return capitulo;
        }

        public void Excluir(Capitulo capitulo)
        {
            try
            {
                Connection.Execute(
                    "DELETE FROM Capitulo WHERE Id = @Id",
                    param: new { Id = capitulo.Id }
                );
            }
            catch (SqlException ex)
            {
                throw new Exception("O capitulo não pode ser removido pois existem cursos vinculados.");
            }
        }
    }
}