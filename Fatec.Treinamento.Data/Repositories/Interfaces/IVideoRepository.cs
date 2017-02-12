using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Fatec.Treinamento.Model.DTO;

namespace Fatec.Treinamento.Data.Repositories.Interfaces
{
    public interface IVideoRepository
    {
        IEnumerable<Video> Listar();
        IEnumerable<Capitulo> ListarCapitulo();
        Video Inserir(Video video);
    }
}
