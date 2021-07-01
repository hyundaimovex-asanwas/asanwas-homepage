package Ehr.yac.a.yaca020.cmd;

import Ehr.yac.a.yaca020.wrk.YACA020WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
        String mode = p_box.get("S_MODE");
        
        //Log.debug.println("S_MODE:"+mode);
        
        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        YACA020WRK wrk = new YACA020WRK();

        // S_MODE�� ��ȸ�� ���
        if (mode.equals("SHR")) {
            wrk.YACA020_SHR(p_box, p_tr);
            
        }else if (mode.equals("SHR_01")) {
        	wrk.YACA020_SHR_01(p_box, p_tr);
        	
        }else if (mode.equals("SHR_13")) {
        	wrk.YACA020_SHR_13(p_box, p_tr);
        	
        }else if (mode.equals("SHR_14")) {
        	wrk.YACA020_SHR_14(p_box, p_tr);        	
  
        }else if (mode.equals("SHR_142")) {
        	wrk.YACA020_SHR_142(p_box, p_tr);            	
        
        }else if (mode.equals("SHR_15")) {
        	wrk.YACA020_SHR_15(p_box, p_tr);            	
       
        }else if (mode.equals("SHR2_14")) {
        	wrk.YACA020_SHR2_14(p_box, p_tr);        	
        	
        }else if (mode.equals("SHR2_142")) {
        	wrk.YACA020_SHR2_142(p_box, p_tr);      
       
        }else if (mode.equals("SHR2_15")) {
        	wrk.YACA020_SHR2_15(p_box, p_tr);      	
        	
        }else if (mode.equals("SHR2_PRT_14")) {
        	wrk.YACA020_SHR2_PRT_14(p_box, p_tr);           	
        	
        }else if (mode.equals("SHR3_PRT_14")) {
        	wrk.YACA020_SHR3_PRT_14(p_box, p_tr);   

        }else if (mode.equals("SHR4_PRT_14")) {
        	wrk.YACA020_SHR4_PRT_14(p_box, p_tr);           	
        	
        }else if (mode.equals("SHR5_PRT_14")) {
        	wrk.YACA020_SHR5_PRT_14(p_box, p_tr);         	
        	
        }else if (mode.equals("SHR2_PRT_142")) {
        	wrk.YACA020_SHR2_PRT_142(p_box, p_tr);           	
        	
        }else if (mode.equals("SHR3_PRT_142")) {
        	wrk.YACA020_SHR3_PRT_142(p_box, p_tr);   

        }else if (mode.equals("SHR4_PRT_142")) {
        	wrk.YACA020_SHR4_PRT_142(p_box, p_tr);           	
        	
        }else if (mode.equals("SHR5_PRT_142")) {
        	wrk.YACA020_SHR5_PRT_142(p_box, p_tr);       
        	
        }else if (mode.equals("SHR2_PRT_15")) {
        	wrk.YACA020_SHR2_PRT_15(p_box, p_tr);           	
        	
        }else if (mode.equals("SHR3_PRT_15")) {
        	wrk.YACA020_SHR3_PRT_15(p_box, p_tr);   

        }else if (mode.equals("SHR4_PRT_15")) {
        	wrk.YACA020_SHR4_PRT_15(p_box, p_tr);           	
        	
        }else if (mode.equals("SHR5_PRT_15")) {
        	wrk.YACA020_SHR5_PRT_15(p_box, p_tr);       	
        	
        }else if (mode.equals("SHR_OLD")) {
        	wrk.YACA020_SHR_OLD(p_box, p_tr);
        }         
        // S_MODE�� ������ ���
        else if (mode.equals("SAV")) {
            wrk.YACA020_SAV(p_box, p_tr);
            
        }else if (mode.equals("SAV_01")) {
        	wrk.YACA020_SAV_01(p_box, p_tr);
        	
        }else if (mode.equals("SAV_CLS")) {
        	wrk.YACA020_SAV_CLS(p_box, p_tr);
        	
        }else if (mode.equals("SAV_END")) {
        	wrk.YACA020_SAV_END(p_box, p_tr);
        	
        }else if (mode.equals("SAV_CLS_14")) {
        	wrk.YACA020_SAV_CLS_14(p_box, p_tr);
        	
        }else if (mode.equals("SAV_END_14")) {
        	wrk.YACA020_SAV_END_14(p_box, p_tr);        	
    
        }else if (mode.equals("SAV_CLS_142")) {
        	wrk.YACA020_SAV_CLS_142(p_box, p_tr);
        	
        }else if (mode.equals("SAV_CLS_15")) {
        	wrk.YACA020_SAV_CLS_15(p_box, p_tr);
        	
        }else if (mode.equals("SAV_END_142")) {
        	wrk.YACA020_SAV_END_142(p_box, p_tr);             	
        	
        }else if (mode.equals("SAV_END_15")) {
        	wrk.YACA020_SAV_END_15(p_box, p_tr);             	
        	
        }                      
		//EjbProxy.controlTxn(new YACA020EJB(p_box, p_tr));
	}
}