@react.component
let make = () => {
  let intArray = Array.fromInitializer(~length=24, i => i)
  let colmArray = Array.fromInitializer(~length=6, n => n * 10)
  let _elemArray = Array.map(intArray, React.int)
  let (currTask, setCurrTask) = React.useState(_ => "")
  let (availableTasks, setAvailTasks) = React.useState(_ =>
    Belt.Set.String.fromArray([
      "bupropion 300mg",
      "orgametril 5mg",
      "vitamin d 30mcg",
      "symbicort",
      "eat1",
      "eat2",
      "eat3",
      "brush teeth",
      "feed cats 1",
      "feed cats 2",
      "clean the litterboxes",
      "leisure time",
      "socializing",
    ])
  )
  let (draggedTask, setDraggedTask) = React.useState(_ => "")
  //let onDragStart = ev => {ev.dataTransfer.dropEffect = move}
  let onDrop = ev => {
    setCurrTask(oldTask => {
      setAvailTasks(availableTasks => Belt.Set.String.add(availableTasks, oldTask))
      draggedTask
    })
    setAvailTasks(availableTasks => Belt.Set.String.remove(availableTasks, draggedTask))
  }
  let onDragOver = (ev: JsxEvent.Mouse.t) => {
    ReactEvent.Mouse.preventDefault(ev)
  }
  //
  <div className="container">
    <table className="table">
      <tbody>
        <tr>
          <th></th>
          {Array.map(colmArray, n => <th scope="col"> {n->React.int} </th>)->React.array}
        </tr>
        {Array.map(intArray, i =>
          <tr key={i->Int.toString}>
            <th scope="row"> {i->React.int} </th>
            <td onDrop onDragOver> {currTask->React.string} </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
        )->React.array}
      </tbody>
    </table>
    <div className="box">
      {Array.map(Belt.Set.String.toArray(availableTasks), availableTask => {
        let onDragStart = ev => {
          setDraggedTask(_ => availableTask)
        }
        <div className="dragelem" draggable=true onDragStart> {availableTask->React.string} </div>
      })->React.array}
    </div>
  </div>
}
// 
