﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Fatec.Treinamento.Model
{
    public class Video
    {
        public static IEnumerable<Capitulo> Capitulo;

        public int Id { get; set; }
        public string Nome { get; set; }
        public int Duracao { get; set; }

        public int IdCapitulo { get; set; }

        public IEnumerable<Capitulo> Capitulos { get; set; }
        public IEnumerable<Video> videos { get; set; }
        public string DuracaoFormatada
        {
            get
            {
                TimeSpan time = TimeSpan.FromSeconds(Duracao);
                return time.ToString(@"hh\:mm\:ss");
            }
        }

        public string CodigoYoutube { get; set; }

        public void Inserir(Video video)
        {
            throw new NotImplementedException();
        }
    }
}
