//Example to get function as argument
//the {} is needed in the argument
import * as React from 'react';
import Box from '@mui/material/Box';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
// import Stack from '@mui/material/Stack';
// import LinearProgress from '@mui/material/LinearProgress';

export default function DepositToken({_sendTokenToAizuMujin, toggle})
{
    // const [toggle,setToggle] = useState(toggle);
    return(<>
        <form>
            <span id="mySymbol">AMT</span><span id="checkText">トークンを貯める</span>
            <br/>
            {/* <input type="text" id="transactionInpt" required="required" /> */}
            <TextField id="transactionInpt" label="amount" variant="outlined" />
            <br/><br/>
            {/* <input type="button" id="transactionBtn" onClick={_sendTokenToAizuMujin} disabled = {toggle} value="トークン送信" /> */}
            <Button id="transactionBtn" onClick={_sendTokenToAizuMujin} disabled = {toggle} variant="contained">トークン送信</Button>

            <br /><br />
        </form>
    </>)
}
