
Ruby sans frontiers
-------------------

A cross-host ruby bridge. Allows you to create and operate on objects
created in ruby runtimes on remote hosts. Frontier uses an ssh connection
and tunnels serializes method calls and replies through it. It's inspired
by Rush, but without the limitation of needing a server process running on
the remote host.

In its pure form, the shell simply forwards all missing methods to the unix
shell (bash or whatever you use). But you can extend the shell through
a system of mixins. There's a few builtin mixins, and you can write your own.


Mixins
------

 * Filesystem: the 'filesystem' mixin provides the method `#[](glob)` which
   returns an array of Pathname objects.

 * Process: the 'process' mixin provides the method 'process' which uses 
   PQL internally to enumerate or find processes.


Limitations
-----------

Frontier uses Marshal internally to serialize objects and Marshal has certain
limitations which objects it can serialize. For example it can't serialize
Proc objects, bindings or IO objects. So you need to pay attention where the
object you created lives, whether on the local or remote host.

For example this won't work:

    server.process.where(:command => /ruby/).each {|p| puts p }

But this will

    server.process.where(:command => /ruby/).all.each {|p| puts p }

This is because where() returns a Plucky::Query object which lives on the
server, so passing a proc to it doesn't work. but where().all() returns an
Array which is lives in the process space on the local host and you can treat
it just like any other array.


Example
-------

    require 'frontier'
    server = Frontier::Shell.new('user@server.tld')

    # Run commands in the unix shell (bash or whatever you use)
    puts server.uname
    puts server.ls '*.rb'

    # Find all ruby processes
    server.load('process')
    puts local.process.where(:command => /ruby/).fields(:pid, :rss).all

    # Get a list of all *.rb files
    server.load('filesystem')
    puts server['*.rb']

    # Recursively copy the ./config directory to the server
    require 'pathname'
    config = Pathname.new('./config/')
    Frontier::Utils.xfer(server['destination/directory'], config)

    # Copy file.txt from server to server2
    server2 = Frontier::Shell.new('user@server2.tld')
    Frontier::Utils.xfer(server2['.'], server['file.txt'])


References
----------

  * [Rush](http://rush.heroku.com/)
  * [PQL](http://github.com/wereHamster/process-query-language)

License
-------

Copyright (c) 2010 by Tomas "wereHamster" Carnecky (tomas.carnecky@gmail.com)
