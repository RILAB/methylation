### Jinliang Yang


library("data.table")
b <- fread("/group/jrigrp4/B73_tissue_WGBS/B73_anther/B73_anther.wgbs.clipOverlap_BSMAP_out.txt")

b[context == "CG" & strand == "+", mean(eff_CT_count, na.rm=TRUE)] 
b[context == "CHG" & strand == "+", mean(eff_CT_count, na.rm=TRUE)] 
b[context == "CHH" & strand == "+", mean(eff_CT_count, na.rm=TRUE)] 


#chr	start	end		
#CT_B73_all3_CG	C_B73_all3_CG	Cratio_B73_all3_CG
#CT_B73_all3_CHG	C_B73_all3_CHG	Cratio_B73_all3_CHG	
#CT_B73_all3_CHH	C_B73_all3_CHH	Cratio_B73_all3_CHH	CT_B73_anther_CG
#C_B73_anther_CG	Cratio_B73_anther_CG	CT_B73_anther_CHG	
#C_B73_anther_CHG	Cratio_B73_anther_CHG	CT_B73_anther_CHH	
#C_B73_anther_CHH	Cratio_B73_anther_CHH	CT_B73_earshoot_CG	
#C_B73_earshoot_CG	Cratio_B73_earshoot_CG	CT_B73_earshoot_CHG	
#C_B73_earshoot_CHG	Cratio_B73_earshoot_CHG	CT_B73_earshoot_CHH	
#C_B73_earshoot_CHH	Cratio_B73_earshoot_CHH	CT_B73_flag_leaf_CG	
#C_B73_flag_leaf_CG	Cratio_B73_flag_leaf_CG	CT_B73_flag_leaf_CHG	
#C_B73_flag_leaf_CHG	Cratio_B73_flag_leaf_CHG	CT_B73_flag_leaf_CHH	
#C_B73_flag_leaf_CHH	Cratio_B73_flag_leaf_CHH	CT_B73_SAM_CG	
#C_B73_SAM_CG	Cratio_B73_SAM_CG	CT_B73_SAM_CHG	C_B73_SAM_CHG
#Cratio_B73_SAM_CHG	CT_B73_SAM_CHH	C_B73_SAM_CHH	Cratio_B73_SAM_CHH



b[, mean(V13, na.rm=TRUE)] 
b[, mean(V16, na.rm=TRUE)] 
b[, mean(V19, na.rm=TRUE)] 
