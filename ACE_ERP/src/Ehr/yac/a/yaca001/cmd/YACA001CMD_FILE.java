package Ehr.yac.a.yaca001.cmd;

import Ehr.yac.a.yaca001.wrk.YACA001WRK;

import java.rmi.RemoteException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.jsp.cmd.AbstractCMD;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;
import com.shift.gef.support.vo.DynamicValueObject;

public class YACA001CMD_FILE implements AbstractCMD {

    public Object execute(HttpServletRequest p_req, HttpServletResponse p_res) throws CException, RemoteException, Throwable {
        
        //String returnPageName = "/Ehr/common/downloadTxtFile.jsp";
        String returnPageName = "../Ehr/common/downloadTxtFile.jsp";
        
        CBox p_box = CollectionUtility.getJspDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

        DynamicValueObject voList = null;

        String mode = p_box.get("S_MODE");

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA001WRK wrk = new YACA001WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("FILE_01")) {
        	
        	voList =wrk.YACA001_SHR_FILE_01(p_box);
            
        } else if (mode.equals("FILE_02")) {
        	
        	voList =wrk.YACA001_SHR_FILE_02(p_box);     
            
        } else if (mode.equals("FILE_03")) {
        	
        	voList =wrk.YACA001_SHR_FILE_03(p_box);            
                
        } else if (mode.equals("FILE_01_142")) {
        	
        	voList =wrk.YACA001_SHR_FILE_01_142(p_box);          	
        	
        } else if (mode.equals("FILE_02_142")) {
        	
        	voList =wrk.YACA001_SHR_FILE_02_142(p_box);     
            
        } else if (mode.equals("FILE_03_142")) {
        	
        	voList =wrk.YACA001_SHR_FILE_03_142(p_box);          	
        	
        } else if (mode.equals("FILE_01_15")) {
        	
        	voList =wrk.YACA001_SHR_FILE_01_15(p_box);
            
        } else if (mode.equals("FILE_02_15")) {
        	
        	voList =wrk.YACA001_SHR_FILE_02_15(p_box);     
            
        } else if (mode.equals("FILE_03_15")) {
        	
        	voList =wrk.YACA001_SHR_FILE_03_15(p_box);            
                
        } 			 
        
        
	
        //DynamicValueObject voList = (DynamicValueObject)EjbProxy.controlNoTxn ( new SAGA120EJB_FILE( p_box ) );
        
        p_req.setAttribute("VO_LIST", voList);   // 처리된 결과를  request에 담아서 화면으로 전달.

        //System.out.println("---->"+returnPageName);
        
        return returnPageName;                   // 처리후 결과를 전달할 URL
        
    }

}
