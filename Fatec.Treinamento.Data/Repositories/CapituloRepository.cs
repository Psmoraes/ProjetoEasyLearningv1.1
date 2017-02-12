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
    public class CapituloRepository: RepositoryBase, ICapituloRepository
    {
        public Capitulo  Inserir(Capitulo  capitulo)
        {

            capitulo.Pontos = 0;
            var id = Connection.ExecuteScalar<int>(
                   @"INSERT INTO Capitulo (Nome,IdCurso,Pontos) 
                 VALUES (@Nome,@IdCurso,@Pontos) 
               SELECT SCOPE_IDENTITY()",
                   param: new
                   {
                       capitulo.Nome,
                       capitulo.IdCurso,
                       capitulo.Pontos 
                       
                   }
               );

            capitulo.Id = id;
            return capitulo;
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
    }
}
