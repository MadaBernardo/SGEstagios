Select *
from Empresa

Select *
from Aluno

Select *
from Oferta_Estagio

Select *
from Historico_Candidatura

Select *
from candidatura

exec SP_AtualizarEstadoCandidatura 15, 'PENDENTE', 'TESTEADMIN'




update Oferta_Estagio
set Estado = 'RECUSADO'
where Id_Estagio = 


