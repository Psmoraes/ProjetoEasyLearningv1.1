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
    public class TreinamentoCursoRepository : RepositoryBase, ITreinamentoRepository
    {
        public TreinamentoCurso Inserir(TreinamentoCurso treinamentocurso)
        {
            var id = Connection.ExecuteScalar<int>(
                   @"INSERT INTO Treinamento (DataInicio,UltimoAcesso,DataConclusao) 
                 VALUES (@DataInicio,@UltimoAcesso,@DataConclusao)
               SELECT SCOPE_IDENTITY()",
                   param: new
                   {
                       treinamentocurso.DataInicio,
                       treinamentocurso.UltimoAcesso,
                       treinamentocurso.DataConclusao

                   }
               );
            return treinamentocurso;
        }
        public TreinamentoCurso Atualizar(TreinamentoCurso treinamentocurso)
        {
            Connection.Execute(
               @"UPDATE TreinamentoCurso SET 
                    Nome = @Nome
                WHERE Id = @Id",
               param: new
               {
                   
                   
               }
            );

            return treinamentocurso;
        }

        public void Excluir(TreinamentoCurso treinamentocurso)
        {
            try
            {
                Connection.Execute(
                    "DELETE FROM Treinamento WHERE Id = @Id",
                    param: new { Id = treinamentocurso.Id }
                );
            }
            catch (SqlException ex)
            {
                throw new Exception("O capitulo não pode ser removido pois existem cursos vinculados.");
            }
        }
    }
}

