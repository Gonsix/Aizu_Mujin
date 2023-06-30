export default function ConnectionButtonConnectionButton({_connectionProcedure})
{
    return(<>
        <div  value="test" id="connectBtn" class="btnUnconnected"  onClick={_connectionProcedure}>
            <button id="marupochi" class="marupochiGlay" value="test" />
            <span id="connectBtnTxt">ウォレットに接続する</span>
        </div>
    </>);
}
