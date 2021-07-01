package sales.org.util;

/**
 * 대용량 스크링 값을 생성자에 명시된 사이즈 (byte단위)로 절단하여 enumerate 객체에
 * 저장해 둔다. 저장된 값을 ByteUtil 내 메소드를 이용해 리턴 받을 수 있다. <br>
 * 데이터 베이스의 대용량 타입 자료를 쓰기 힘들 경우 VARCHAR2() 타입으로 구성된 서브 테이블을 
 * 구성해서 여러개의 row로 나누어 저장 할 경우 유용하게 쓰일 수 있다.<br>  
 * 
 * <pre>
 * 	<사용예>		
 * 
 * 	ArrayList token = new ArrayList();			// 저장소 
 * 
 * 	String contents = "XXXX.........XXXX";		// 대용량 스트링
 * 
 *	ByteUtil byteUtil = new ByteUtil(contents, 3000);	// 3000bytes 단위로 파싱한다.
 *			
 *	int i = 0;
 *
 *	while(byteUtil.hasNext())
 *		token.add(byteUtil.nextToken());		// 3000bytes 씩 저장소에 저장한다.
 * </pre>
 * 
 * @author pronema
 *
 */
public class ByteUtil
{
    private static final String CUT_POSTFIX = "...";

    private byte[] buffer;
    private int tokenSize;
    private int workingIndex;

    /**
     * 생성자 원본 대용랑 스트링과 파싱 사이즈(byte 단위)를 전달 받는다.
     * 
     * @param string		<code>대용랑 문자열</code>
     * @param tokenSize	<code>사이즈 (byte단위)</code>
     * 
     */
    public ByteUtil(String string, int tokenSize)
    {
        this(string.getBytes(), tokenSize);
    }

    /**
     * 생성자 원본 대용랑 스트링이 저장 된 byte배열과 파싱 사이즈(byte 단위)를 전달 받는다.
     * 
     * @param buffer		<code>대용량 문자열이 저장된 byte 배열</code>
     * @param tokenSize	<code>사이즈 (byte단위)</code>
     * 
     */
    public ByteUtil(byte[] buffer, int tokenSize)
    {
        this.buffer = buffer;
        this.tokenSize = tokenSize;

        workingIndex = 0;
    }

    /**
     * 파싱할 부분이 존재하는지 체크한다.
     * 
     * @return <code>존재 여부 (ture : 존재함, false : 존재 안함)</code> 
     * 
     */
    public boolean hasNext()
    {
        if (workingIndex < buffer.length) return true;
        return false;
    }

    /**
     * 파싱한 문자열을 리턴한다.
     * 
     * @return <code>파싱된 문자열</code> 
     * 
     */
    public String nextToken()
    {
        if (!hasNext()) return null;

        int workingTokenSize = tokenSize;
        
        if (getExpectedIndex(workingTokenSize) > buffer.length - 1) 
        	workingTokenSize = buffer.length - workingIndex;

        int backStepCounter = 0;
        
        while (true)
        {
            int testIndex = getExpectedIndex(workingTokenSize) - 1 - backStepCounter;

            if(workingIndex > testIndex) 
            	break;

            byte testByte = buffer[testIndex];
            
            if (testByte >= 0 && testByte <= 255) 
            	break;

            backStepCounter++;
        }

        workingTokenSize -= backStepCounter % 2;

        String nextToken = new String(buffer, workingIndex, workingTokenSize);
        
        workingIndex = getExpectedIndex(workingTokenSize);

        return nextToken;
    }

    /**
     * 원본 문자열에서 사이즈에 해당하는 만큼 파싱한 문자열을 리턴한다. 
     * 
     * @return <code>파싱된 문자열</code> 
     * 
     */
    public static String getCutString(String str, int tokenSize)
    {
        byte[] buf = str.getBytes();

        if (tokenSize >= buf.length) return str;

        int size = tokenSize - CUT_POSTFIX.length();
        
        ByteUtil bt = new ByteUtil(buf, size);

        String token = bt.nextToken();
        
        if (bt.hasNext()) 
        	token = token + CUT_POSTFIX;

        return token;
    }

    private int getExpectedIndex(int workingTokenSize)
    {
        return workingIndex + workingTokenSize;
    }
}
