using Fatec.Treinamento.Data.Repositories.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Fatec.Treinamento.Model.DTO;
using Fatec.Treinamento.Data.Repositories.Base;
using Dapper;
using Fatec.Treinamento.Model;

namespace Fatec.Treinamento.Data.Repositories
{
    public class DocumentoRepository : RepositoryBase, IDocumentoRepository
    {
        public Documento Inserir(Documento documento)
        {
            var id = Connection.ExecuteScalar<int>(
               @"INSERT INTO Documento (Id, Descricao) 
                 VALUES (@Id, @Descricao); 
               SELECT SCOPE_IDENTITY()",
               param: new
               {
                   documento.Id,
                   documento.Descricao
               }
           );

            documento.Id = id;
            return documento;
        }

        public Documento Obter(int id)
        {
            return Connection.Query<Documento>(
               "SELECT Id, Nome FROM Documento WHERE Id = @Id",
               param: new { Id = id }
           ).FirstOrDefault();
        }


        public Documento Atualizar(Documento documento)
        {
            Connection.Execute(
               @"UPDATE Documento SET 
                    Nome = @Nome
                WHERE Id = @Id",
               param: new
               {
                   documento.Nome,
                   documento.Id
               }
            );

            return documento;
        }

        public void Excluir(Documento documento)
        {
            try
            {
                Connection.Execute(
                    "DELETE FROM Documento WHERE Id = @Id",
                    param: new { Id = documento.Id }
                );
            }
            catch (SqlException ex)
            {
                throw new Exception("O Documento não pode ser removido pois existem cursos vinculados.");
            }
        }

    }
}