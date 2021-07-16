################################################
# Get value from nested object by function    ##
# Author: Lingaraj Raul                       ##
################################################


function GetValue($object, $key)
{
    $p1,$p2 = $key.Split("/")
    $value1, $value2 = $object.Split(":")
    if($p2) { return GetValue -object $value2 -key $p2 }
    else 
        { 
            Write-Host $value2
            $value = $value2.Tostring()
            return $value[1]
         }
}

$Obj =  '{“x”:{“y”:{“z”:”a”}}}'
$Key = "x/y/z"

GetValue $Obj -key $Key.Split("/")


<#

object = {“x”:{“y”:{“z”:”a”}}}
key = x/y/z
value = a
#>