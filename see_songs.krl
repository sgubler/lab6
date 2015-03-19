ruleset see_songs {
  meta {
    name "See Songs"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    sharing on
    provides hello
 
  }
  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
 
  }
  rule songs {
    select when echo message msg_type re#song#
    send_directive("sing") with
      song = event:attr("input");
    always {
      raise explicit event sung with
        song = event:attr("input");
    }
  }
  rule find_hymn {
    select when explicit sung
    pre {
      song = event:attr("song").klog("<< song >>");
    }
    if(song.match(re#.*god.*#)) then {
      noop();
    }
    fired {
      raise explicit event found_hymn;
    }
  }
}

