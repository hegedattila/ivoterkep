<?php

return [
    'passGen' => function ($p){
        return sha1(substr(md5($p), 0, 21) . 'iv0t3rk3pP#P');
    },
];
