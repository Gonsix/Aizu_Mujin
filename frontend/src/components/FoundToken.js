//Example to get function as argument
//the {} is needed in the argument
import * as React from 'react';
import Box from '@mui/material/Box';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
export default function FoundToken({_transferAllToken, toggle2})
{
    return (<>
        <form>
            <h2>すべてのトークンを投資</h2>
            <span id="checkText">宛先のアドレスを入力</span>
            <br/>
            {/* <input type="text" id="aizuMujinInpt" required="required" /> */}
            <TextField id="aizuMujinInpt" label="Address" variant="outlined" />
            <br/><br/>
            {/* <input type="button" id="aizuMujinBtn" onClick={()=>{_transferAllToken()}} value="会津無尽" disabled={toggle2}/> */}
            <Button id="aizuMujinBtn" onClick={()=>{_transferAllToken()}} disabled={toggle2} variant="contained">会津無尽</Button>
            <br /><br />
        </form>
    </>);
}
