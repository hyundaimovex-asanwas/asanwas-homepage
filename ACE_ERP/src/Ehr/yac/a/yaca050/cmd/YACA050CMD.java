package Ehr.yac.a.yaca050.cmd;

import Ehr.yac.a.yaca050.wrk.YACA050WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        YACA050WRK wrk = new YACA050WRK();

        // S_MODE�� ��ȸ�� ���
        if (p_box.get("S_MODE").equals("SHR")) {
            wrk.YACA050_SHR(p_box, p_tr);
            
    	//	S_MODE�� ��ȸ�� ���
        }else if (p_box.get("S_MODE").equals("SHR_14")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_SHR_14(p_box, p_tr);           
            
        	//	S_MODE�� ��ȸ�� ���
        }else if (p_box.get("S_MODE").equals("SHR_142")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_SHR_142(p_box, p_tr);    
    		//	S_MODE�� ��ȸ�� ���
        }else if (p_box.get("S_MODE").equals("SHR_15")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_SHR_15(p_box, p_tr);     
    	
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_142(p_box, p_tr);  	
    		
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_15")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_15(p_box, p_tr);  		
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_3")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_142_3(p_box, p_tr);  
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_3")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_15_3(p_box, p_tr);  
    			
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_142_4(p_box, p_tr);  
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_1")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_142_4_1(p_box, p_tr);  	
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_2")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_142_4_2(p_box, p_tr);  	
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_3")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_142_4_3(p_box, p_tr);  	
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_4")) {
    		//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
    		wrk.YACA050_PRT_142_4_4(p_box, p_tr);  		
    		
        		
        
		}else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4")) {
			//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA050_PRT_15_4(p_box, p_tr);  
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_1")) {
			//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA050_PRT_15_4_1(p_box, p_tr);  	
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_2")) {
			//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA050_PRT_15_4_2(p_box, p_tr);  	
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_3")) {
			//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA050_PRT_15_4_3(p_box, p_tr);  	
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_4")) {
			//��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA050_PRT_15_4_4(p_box, p_tr);  		
			
	    } 		

		//EjbProxy.controlTxn(new YACA050EJB(p_box, p_tr));
	}
}