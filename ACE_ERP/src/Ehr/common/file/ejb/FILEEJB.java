package common.file.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.file.wrk.FILEWRK;

public class FILEEJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public FILEEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		FILEWRK wrk = new FILEWRK();
        String mode = box.get("S_MODE");
		
		if (mode.equals("SHR"))
			wrk.FILE_SHR(box, trBox);
        else if (mode.equals("INS"))
            wrk.FILE_INS(box, trBox);
        else if (mode.equals("DEL"))
            wrk.FILE_DEL(box, trBox);
		
		return null;
	}

}
