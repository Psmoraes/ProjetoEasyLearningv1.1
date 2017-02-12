using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Fatec.Treinamento.Model
{
    public class Documento
    {
        public int Id { get; set; }
        public int IdCurso { get; set; }
        public int Descricao { get; set; }
        public DateTime DataCadastro { get; set; }
        public string Arquivo { get; set; }
        public string Nome { get; set; }
    }
}
