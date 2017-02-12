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
    public class VideoRepository: RepositoryBase, IVideoRepository
    {
        public Video Inserir(Video video)
        {
            var id = Connection.ExecuteScalar<int>(
               @"INSERT INTO Video (Nome) 
                 VALUES (@Nome); 
               SELECT SCOPE_IDENTITY()",
               param: new
               {
                   video.Nome
               }
           );

            video.Id = id;
            return video;
        }

        public IEnumerable<Video> Listar()
        {
            return Connection.Query<Video>(
              @"SELECT Id, Nome FROM Video
                ORDER BY Nome ASC"
            ).ToList();
        }
        public IEnumerable<Capitulo> ListarCapitulo()
        {
            return Connection.Query<Capitulo>(
              @"SELECT Id, Nome FROM Video
                ORDER BY Nome ASC"
            ).ToList();
        }

        public Video Obter(int id)
        {
            return Connection.Query<Video>(
               "SELECT Id, Nome FROM Video WHERE Id = @Id",
               param: new { Id = id }
           ).FirstOrDefault();
        }


        public Video Atualizar(Video video)
        {
            Connection.Execute(
               @"UPDATE Video SET 
                    Nome = @Nome
                WHERE Id = @Id",
               param: new
               {
                   video.Nome,
                   video.Id
               }
            );

            return video;
        }

        public void Excluir(Video video)
        {
            try
            {
                Connection.Execute(
                    "DELETE FROM Video WHERE Id = @Id",
                    param: new { Id = video.Id }
                );
            }
            catch (SqlException ex)
            {
                throw new Exception("O capitulo não pode ser removido pois existem cursos vinculados.");
            }
        }
    }

}