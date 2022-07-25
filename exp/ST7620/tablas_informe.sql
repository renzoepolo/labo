-- Adaptacion para grafico
update cluster_de_bajas_12meses set pos = -pos;

-- Analisis de segmentos
select	cluster2,
		count(*),
        --PC1
		avg(mtarjeta_visa_consumo) mtarjeta_visa_consumo, 
		avg(ctarjeta_visa_trx) ctarjeta_visa_trx, 
		avg(ctrx_quarter) ctrx_quarter, 
		avg("Visa_mpagospesos") Visa_mpagospesos, 
		avg("Visa_Fvencimiento") Visa_Fvencimiento,
		avg(mtarjeta_visa_consumo)+avg("Visa_mpagospesos") deuda_visa,
		--PC2
		avg("Visa_mpagominimo") Visa_mpagominimo, 
		avg(mactivos_margen) mactivos_margen, 
		avg("Visa_msaldopesos") Visa_msaldopesos, 
		avg("Visa_msaldototal") Visa_msaldototal, 
		avg("Visa_cconsumos") Visa_cconsumos, 
		avg(mcuentas_saldo) mcuentas_saldo,
		--PC3
		avg(mcomisiones) mcomisiones, 
		avg("Visa_fechaalta")/30/12 Visa_fechaalta, 
		avg("Master_fechaalta")/30/12 Master_fechaalta, 
		avg(cliente_antiguedad)/12 cliente_antiguedad, 
		avg(mcaja_ahorro) mcaja_ahorro, 
		avg(mpayroll) mpayroll,
		avg(mpayroll)/avg(mcaja_ahorro) ratio,
		sum(cliente_vip) cliente_vip
from cluster_de_bajas 
group by cluster2
order by cluster2;

-- Analisis temporal
select 	cluster2,
		pos,
		string_agg(distinct clase_ternaria, ','), 
		avg(mcuentas_saldo) mcuentas_saldo,
		avg(ctrx_quarter) ctrx_quarter,
		avg(mpayroll) mpayroll,
		avg(mcaja_ahorro) mcaja_ahorro
from	cluster_de_bajas_12meses
group by	pos,cluster2
order by	cluster2,pos;


select foto_mes, count(*)
from public.cluster_de_bajas
group by foto_mes;

select foto_date + interval '1 month', count(*)
from public.cluster_de_bajas_12meses
where clase_ternaria = 'BAJA+1' and foto_date > '2020-03-01'
group by foto_date
order by foto_date;