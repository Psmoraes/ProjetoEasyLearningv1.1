﻿using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Fatec.Treinamento.Model.DTO;

namespace Fatec.Treinamento.Data.Repositories.Interfaces
{
    public interface ICursoRepository 
    {
        IEnumerable<DetalhesCurso> ListarCursosPorNome(string nome);

        IEnumerable<DetalhesCurso> ListarCursos();

        IEnumerable<DetalhesCurso> ListarCursosPorAssunto(int idAssunto);

        IEnumerable<DetalhesCurso> ListarCursosDetalhes();

        DetalhesCurso ObterDetalhesCurso(int id);

        Curso Inserir(Curso curso);
    }
}
