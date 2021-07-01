package Ehr.yac.a.yaca021.cmd;

import Ehr.yac.a.yaca021.wrk.YACA021WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA021CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
        
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
        
        String mode = p_box.get("S_MODE");

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA021WRK wrk = new YACA021WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.YACA021_SHR(p_box, p_tr);
            
        }else if (mode.equals("SHR_13")) {
            wrk.YACA021_SHR_13(p_box, p_tr);
            
        }else if (mode.equals("SHR_14")) {
            wrk.YACA021_SHR_14(p_box, p_tr);            
            
        }else if (mode.equals("SHR_142")) {
            wrk.YACA021_SHR_142(p_box, p_tr);  
        
        }else if (mode.equals("SHR_15")) {
            wrk.YACA021_SHR_15(p_box, p_tr);      
            
        }else if (mode.equals("SHR_INFO")) {
            wrk.YACA021_SHR_INFO(p_box, p_tr);
            
        }else if (mode.equals("SHR_INFO_14")) {
            wrk.YACA021_SHR_INFO_14(p_box, p_tr);            
            
        }else if (mode.equals("SHR_INFO_142")) {
            wrk.YACA021_SHR_INFO_142(p_box, p_tr);   
            
        }else if (mode.equals("SHR_INFO_15")) {
            wrk.YACA021_SHR_INFO_15(p_box, p_tr);       
            
        }else if (mode.equals("SHR_PER")) {
            wrk.YACA021_SHR_PER(p_box, p_tr);
            
        }else if (mode.equals("SHR_PER_14")) {
            wrk.YACA021_SHR_PER_14(p_box, p_tr);            
            
        }else if (mode.equals("SHR_PER_142")) {
            wrk.YACA021_SHR_PER_142(p_box, p_tr);  
            
        }else if (mode.equals("SHR_PER_15")) {
            wrk.YACA021_SHR_PER_15(p_box, p_tr);           
            
        }else if (mode.equals("SHR_RENT")) {
            wrk.YACA021_SHR_RENT(p_box, p_tr);
            
        }else if (mode.equals("SHR_RENT_14")) {
            wrk.YACA021_SHR_RENT_14(p_box, p_tr);            
            
        }else if (mode.equals("SHR_RENT_142")) {
            wrk.YACA021_SHR_RENT_142(p_box, p_tr);   
        
        }else if (mode.equals("SHR_RENT_15")) {
            wrk.YACA021_SHR_RENT_15(p_box, p_tr);  
            
        } else if (mode.equals("INS")) {
            wrk.YACA021_INS(p_box, p_tr);

        } else if (mode.equals("INS_14")) {
            wrk.YACA021_INS_14(p_box, p_tr);            
        
        } else if (mode.equals("INS_142")) {
            wrk.YACA021_INS_142(p_box, p_tr);
            
        } else if (mode.equals("INS_15")) {
            wrk.YACA021_INS_15(p_box, p_tr);       
            
		}else if (mode.equals("SAV_PER")) {
            wrk.YACA021_SAV_PER(p_box, p_tr);
            
        }else if (mode.equals("SAV_PER_14")) {
            wrk.YACA021_SAV_PER_14(p_box, p_tr);            
            
        }else if (mode.equals("SAV_PER_142")) {
            wrk.YACA021_SAV_PER_142(p_box, p_tr);  
            
        }else if (mode.equals("SAV_PER_15")) {
            wrk.YACA021_SAV_PER_15(p_box, p_tr);     
            
        }else if (mode.equals("SAV_RENT")) {
            wrk.YACA021_SAV_RENT(p_box, p_tr);
            
        }else if (mode.equals("SAV_RENT_14")) {
            wrk.YACA021_SAV_RENT_14(p_box, p_tr);            
            
        }else if (mode.equals("SAV_RENT_142")) {
            wrk.YACA021_SAV_RENT_142(p_box, p_tr);    
            
        }else if (mode.equals("SAV_RENT_15")) {
            wrk.YACA021_SAV_RENT_15(p_box, p_tr);   
            
        }else if (mode.equals("UPT")) {
            wrk.YACA021_UPT(p_box, p_tr);
            
        }else if (mode.equals("UPT_14")) {
            wrk.YACA021_UPT_14(p_box, p_tr);            
            
        }else if (mode.equals("UPT_142")) {
            wrk.YACA021_UPT_142(p_box, p_tr);  
            
        }else if (mode.equals("UPT_15")) {
            wrk.YACA021_UPT_15(p_box, p_tr);        
            
        }else if (mode.equals("DEL")) {
            wrk.YACA021_DEL(p_box, p_tr);
            
        }else if (mode.equals("DEL_14")) {
            wrk.YACA021_DEL_14(p_box, p_tr);            
            
        }else if (mode.equals("DEL_142")) {
            wrk.YACA021_DEL_142(p_box, p_tr);       
            
        }else if (mode.equals("DEL_15")) {
            wrk.YACA021_DEL_15(p_box, p_tr);           
            
        }else if (mode.equals("ACC")) {
            wrk.YACA021_ACC(p_box, p_tr);
            
        }else if (mode.equals("ACC_14")) {
            wrk.YACA021_ACC_14(p_box, p_tr);            
            
        }else if (mode.equals("ACC_142")) {
            wrk.YACA021_ACC_142(p_box, p_tr);                
            
        }
	}
}