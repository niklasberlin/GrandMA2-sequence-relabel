local seqStart = 1;
local seqEnd = 1000;


-- *********************************************
-- demonstrate how to get the program parameters
-- *********************************************

local internal_name    = select(1,...);
local visible_name     = select(2,...);

gma.echo("Hello, you loaded the plugin " .. internal_name); -- you will see this message in the system monitor

-- *********************************************
-- the plugin entry point
-- *********************************************

function Start()
    local O=gma.show.getobj; -- create fast shortcut for functionblock. this is speeding up the script significantly
    for seq = seqStart, seqEnd, 1 do
        --gma.echo(seq);
        local handle=O.handle("sequence "..seq);
        if(handle) then
            local name = O.label(handle);
            if string.find(name, "#") then
                local start = string.find(name, "#");
                name = string.sub(name, 0, start-1);
                gma.cmd('label sequence '..seq..' "'..name..'"');
            end
        end
    end
end

function Cleanup()
    gma.echo("Cleanup called");
end

-- *********************************************
-- this is important: when a plugin is loaded,
-- it MUST return the program entry function.
-- optionally a cleanup function can also be
-- returned, it will be called when the plugin
-- is terminated.
-- *********************************************

return Start,Cleanup;

-- *********************************************
-- currently implemented functions are:
-- *********************************************
--
--
--                            gma.sleep(number:sleep_seconds)
--                            gma.echo(all kind of values)
--                            gma.feedback(all kind of values)
--
-- string:build_date        = gma.build_date()
-- string:build_time        = gma.build_time()
-- string:version_hash      = gma.git_version()
--
--                            gma.export(string:filename,table:export_data)
--                            gma.export_csv(string:filename,table:export_data)
--                            gma.export_json(string:filename,table:export_data)
-- table:import_data        = gma.import(string:filename, [string:gma_subfolder])
--
--                            gma.cmd(string:command)
--                            gma.timer(function:name,number:dt,number:max_count,[function:cleanup])
-- number:time              = gma.gettime()
-- string:result            = gma.textinput(string:title,[string:old_text])
--
-- bool:result              = gma.gui.confirm(string:title,string:message)
--                          = gma.gui.msgbox(string:title,string:message)
--
-- number:handle            = gma.gui.progress.start(string:progress_name)
--                            gma.gui.progress.stop(number:progress_handle)
--                            gma.gui.progress.settext(number:progress_handle,string:text)
--                            gma.gui.progress.setrange(number:progress_handle,number:from,number:to)
--                            gma.gui.progress.set(number:progress_handle,number:value)
--
-- number:value             = gma.show.getdmx(number:dmx_addr)
-- table:values             = gma.show.getdmx(table:recycle,number:dmx_addr,number:amount)
--
-- number:handle            = gma.show.getobj.handle(string:name)
-- string:classname         = gma.show.getobj.class(number:handle)
-- number:index             = gma.show.getobj.index(number:handle)
-- number:commandline_number= gma.show.getobj.number(number:handle)
-- string:name              = gma.show.getobj.name(number:handle)
-- string:label             = gma.show.getobj.label(number:handle)  returns nil if object has no label set
-- number:amount_children   = gma.show.getobj.amount(number:handle)
-- number:child_handle      = gma.show.getobj.child(number:handle, number:index)
-- number:parent_handle     = gma.show.getobj.parent(number:handle)
-- bool:result              = gma.show.getobj.verify(number:handle)
-- bool:result              = gma.show.getobj.compare(number:handle1,number:handle2)
--
-- number:amount            = gma.show.property.amount(number:handle)
-- string:property_name     = gma.show.property.name(number:handle,number:index)
-- string:property          = gma.show.property.get(number:handle,number:index/string:property_name)
--
-- string:value             = gma.show.getvar(string:varname)
--                            gma.show.setvar(string:varname,string:value)
--
-- string:value             = gma.user.getvar(string:varname)
--                            gma.user.setvar(string:varname,string:value")
-- number:object handle     = gma.user.getcmddest()
-- number:object_handle     = gma.user.getselectedexec()
--
-- string:type              = gma.network.gethosttype()
-- string:subtype           = gma.network.gethostsubtype()
-- string:ip                = gma.network.getprimaryip()
-- string:ip                = gma.network.getsecondaryip()
-- string:status            = gma.network.getstatus()
-- number:session_number    = gma.network.getsessionnumber()
-- string:session_name      = gma.network.getsessionname()
-- number:slot              = gma.network.getslot()
--
-- table:host_data          = gma.network.gethostdata(string:ip,[table:recycle])
-- table:slot_data          = gma.network.getmanetslot(number:slot,[table:recycle])
-- table:performance_data   = gma.network.getperformance(number:slot,[table:recycle])

-- string:type              = gma.gethardwaretype()