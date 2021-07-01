package common.menu.userauth.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.menu.userauth.wrk.USERAUTHWRK;

public class USERAUTHEJB extends EJB {
	public CBox box = null;
    public TrBox trBox = null;
    public USERAUTHEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		USERAUTHWRK wrk = new USERAUTHWRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (box.get("S_MODE").equals("SHR_00")) {

			//사용자권한정보조회
			wrk.USERAUTH_SHR_00(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {

			//권한에 따른 메뉴트리 조회(신인사시스템)
			wrk.USERAUTH_SHR_01(box, trBox);
		}
		
		else if (box.get("S_MODE").equals("SHR_02")) {

			//권한에 따른 메뉴트리 조회(경영정보시스템)
			wrk.USERAUTH_SHR_02(box, trBox);
		}	
        
		else if (box.get("S_MODE").equals("SHR_03")) {
		    
		    //사용자가 사용가능한 상위 메뉴를 가지고 온다.
		    wrk.USERAUTH_SHR_03(box, trBox);
		}		
        
		else if (box.get("S_MODE").equals("SHR_04")) {
		    
		    //EIS에서 사용 가능한 상위 메뉴를 가지고 온다.
		    wrk.USERAUTH_SHR_04(box, trBox);
		}
		
		else if (box.get("S_MODE").equals("SHR_05")) {
			
			//sso
			wrk.USERAUTH_SHR_05(box, trBox);
		}		

		return null;
	}

}
