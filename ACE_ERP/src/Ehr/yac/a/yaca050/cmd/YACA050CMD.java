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
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA050WRK wrk = new YACA050WRK();

        // S_MODE가 조회인 경우
        if (p_box.get("S_MODE").equals("SHR")) {
            wrk.YACA050_SHR(p_box, p_tr);
            
    	//	S_MODE가 조회인 경우
        }else if (p_box.get("S_MODE").equals("SHR_14")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_SHR_14(p_box, p_tr);           
            
        	//	S_MODE가 조회인 경우
        }else if (p_box.get("S_MODE").equals("SHR_142")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_SHR_142(p_box, p_tr);    
    		//	S_MODE가 조회인 경우
        }else if (p_box.get("S_MODE").equals("SHR_15")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_SHR_15(p_box, p_tr);     
    	
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_142(p_box, p_tr);  	
    		
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_15")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_15(p_box, p_tr);  		
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_3")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_142_3(p_box, p_tr);  
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_3")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_15_3(p_box, p_tr);  
    			
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_142_4(p_box, p_tr);  
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_1")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_142_4_1(p_box, p_tr);  	
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_2")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_142_4_2(p_box, p_tr);  	
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_3")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_142_4_3(p_box, p_tr);  	
    		
        }else if (p_box.get("S_MODE").equals("YACA050_PRT_142_4_4")) {
    		//결과 내역 조회를 위한 WORK메소드 호출
    		wrk.YACA050_PRT_142_4_4(p_box, p_tr);  		
    		
        		
        
		}else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4")) {
			//결과 내역 조회를 위한 WORK메소드 호출
			wrk.YACA050_PRT_15_4(p_box, p_tr);  
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_1")) {
			//결과 내역 조회를 위한 WORK메소드 호출
			wrk.YACA050_PRT_15_4_1(p_box, p_tr);  	
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_2")) {
			//결과 내역 조회를 위한 WORK메소드 호출
			wrk.YACA050_PRT_15_4_2(p_box, p_tr);  	
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_3")) {
			//결과 내역 조회를 위한 WORK메소드 호출
			wrk.YACA050_PRT_15_4_3(p_box, p_tr);  	
			
	    }else if (p_box.get("S_MODE").equals("YACA050_PRT_15_4_4")) {
			//결과 내역 조회를 위한 WORK메소드 호출
			wrk.YACA050_PRT_15_4_4(p_box, p_tr);  		
			
	    } 		

		//EjbProxy.controlTxn(new YACA050EJB(p_box, p_tr));
	}
}