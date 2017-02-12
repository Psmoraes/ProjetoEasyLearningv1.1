using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Fatec.Treinamento.Model
{
    public class Curso
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public int IdAssunto { get; set; }
        public int IdAutor { get; set; }
        public int Classificacao { get; set; }
        public DateTime DataCricao { get; set; }

        public IEnumerable<Assunto> ListaAssunto { get; set; }
        public IEnumerable<Usuario> ListaUsuario { get; set; }
        public IEnumerable<Capitulo> ListaCapitulo { get; set; }


    }
}
