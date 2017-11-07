<?php
namespace System;

class UserGroupHandler {
    
    public static function getGroups($mode = 'ASSOC') {
        return (new \System\SystemModels\Tables\uGroupTable())->getGroups($mode);
    }
}
