//Example to get function as argument
//the {} is needed in the argument
export default function FoundToken({_transferAllToken, toggle2})
{
    return (<>
        <form>
            <h2>すべてのトークンを投資</h2>
            <span id="checkText">宛先のアドレスを入力</span>
            <br/>
            <input type="text" id="aizuMujinInpt" required="required" />
            <br/><br/>
            <input type="button" id="aizuMujinBtn" onClick={()=>{_transferAllToken()}} value="会津無尽" disabled={toggle2}/>
            <br /><br />
        </form>
    </>);
}
